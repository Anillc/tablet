import Clutter from 'gi://Clutter';
import Gio from 'gi://Gio';
import GLib from 'gi://GLib';
import St from 'gi://St';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';
import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';

const IFACE = 'org.gnome.Mutter.DisplayConfig';
const PATH = '/org/gnome/Mutter/DisplayConfig';
const TRANSFORM = 3;

const sh = cmd => Gio.Subprocess.new(['sudo', 'sh', '-c', cmd], 0);
const sleep = t => new Promise(resolve => setTimeout(resolve, t));

function rotate() {
    Gio.DBus.session.call(IFACE, PATH, IFACE, 'GetCurrentState', null, null,
        Gio.DBusCallFlags.NONE, -1, null, (conn, res) => {
            const [serial, monitors, logical] = conn.call_finish(res).deepUnpack();
            const isBuiltin = c => monitors.find(m => m[0][0] === c)?.[2]?.['is-builtin']?.unpack();
            const current = logical.find(([, , , , , lm]) => lm.some(([c]) => isBuiltin(c)));
            if (current && current[3] === TRANSFORM)
                return;
            const lms = logical.map(([x, y, scale, transform, primary, lm]) => [
                x, y, scale,
                lm.some(([c]) => isBuiltin(c)) ? TRANSFORM : transform,
                primary,
                lm.map(([c]) => {
                    const modes = monitors.find(m => m[0][0] === c)[1];
                    const mode = modes.find(m => m[6]['is-current']?.unpack()) ?? modes[0];
                    return [c, mode[0], {}];
                }),
            ]);
            conn.call(IFACE, PATH, IFACE, 'ApplyMonitorsConfig',
                new GLib.Variant('(uua(iiduba(ssa{sv}))a{sv})', [serial, 1, lms, {}]),
                null, Gio.DBusCallFlags.NONE, -1, null, null);
        });
}

export default class FolioResetExtension extends Extension {
    enable() {
        this._button = new PanelMenu.Button(0.5, 'Folio USB Reset', true);
        this._button.add_child(new St.Icon({
            icon_name: 'system-reboot-symbolic',
            style_class: 'system-status-icon',
        }));
        const click = new Clutter.ClickGesture();
        click.set_recognize_on_press(true);
        click.connect('recognize', () => {
            this._reset();
        });
        this._button.add_action(click);
        Main.panel.addToStatusArea('folio-reset', this._button);

        this._seat = global.stage.context.get_backend().get_default_seat();
        this._seat.connectObject('notify::touch-mode', () => this._sync(), this);
        this._sync();
    }

    disable() {
        this._seat.disconnectObject(this);
        this._seat = null;
        this._button?.destroy();
        this._button = null;
    }

    _sync() {
        this._button.visible = !this._seat.touch_mode;
    }

    async _reset() {
        sh('echo -n 0000:00:14.0 > /sys/bus/pci/drivers/xhci_hcd/unbind');
        await sleep(500);
        sh('echo -n 0000:00:14.0 > /sys/bus/pci/drivers/xhci_hcd/bind');
        const folio = Gio.File.new_for_path('/sys/bus/usb/devices/1-3');
        for (let i = 0; i < 50 && !folio.query_exists(null); i++)
            await sleep(100);
        await sleep(500);
        rotate();
    }
}
