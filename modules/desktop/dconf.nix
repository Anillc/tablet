# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/anillc/.local/share/backgrounds/2023-06-21-19-22-44-%7BA549BEAA-044A-36B6-C635-188798168B17%7D.png";
      picture-uri-dark = "file:///home/anillc/.local/share/backgrounds/2023-06-21-19-22-44-%7BA549BEAA-044A-36B6-C635-188798168B17%7D.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "default";
      enable-animations = true;
      show-battery-percentage = true;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    "org/gnome/settings-daemon/peripherals/touchscreen" = {
      orientation-lock = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt>s";
      command = "share-file";
      name = "share-file";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      ambient-enabled = false;
      idle-dim = false;
      power-button-action = "suspend";
      power-saver-profile-on-low-battery = true;
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      app-picker-layout = "[{'org.gnome.Geary.desktop': <{'position': <0>}>, 'org.gnome.Contacts.desktop': <{'position': <1>}>, 'org.gnome.Weather.desktop': <{'position': <2>}>, 'org.gnome.clocks.desktop': <{'position': <3>}>, 'org.gnome.Maps.desktop': <{'position': <4>}>, 'org.gnome.Photos.desktop': <{'position': <5>}>, 'org.gnome.Totem.desktop': <{'position': <6>}>, 'android-studio.desktop': <{'position': <7>}>, 'org.gnome.Calculator.desktop': <{'position': <8>}>, 'arduino.desktop': <{'position': <9>}>, 'simple-scan.desktop': <{'position': <10>}>, 'org.gnome.Settings.desktop': <{'position': <11>}>, 'gnome-system-monitor.desktop': <{'position': <12>}>, 'discord.desktop': <{'position': <13>}>, 'Utilities': <{'position': <14>}>, 'element-desktop.desktop': <{'position': <15>}>, 'yelp.desktop': <{'position': <16>}>, 'org.gnome.Extensions.desktop': <{'position': <17>}>, 'org.gnome.Cheese.desktop': <{'position': <18>}>, 'org.fcitx.Fcitx5.desktop': <{'position': <19>}>, 'fcitx5-configtool.desktop': <{'position': <20>}>, 'org.fcitx.fcitx5-migrator.desktop': <{'position': <21>}>, 'firefox.desktop': <{'position': <22>}>, 'clash-verge.desktop': <{'position': <23>}>}, {'fish.desktop': <{'position': <0>}>, 'htop.desktop': <{'position': <1>}>, 'idea-community.desktop': <{'position': <2>}>, 'org.kde.kdeconnect.app.desktop': <{'position': <3>}>, 'org.kde.kdeconnect.nonplasma.desktop': <{'position': <4>}>, 'org.kde.kdeconnect-settings.desktop': <{'position': <5>}>, 'org.kde.kdeconnect.sms.desktop': <{'position': <6>}>, 'kbd-layout-viewer5.desktop': <{'position': <7>}>, 'org.kicad.kicad.desktop': <{'position': <8>}>, 'org.kicad.gerbview.desktop': <{'position': <9>}>, 'org.kicad.bitmap2component.desktop': <{'position': <10>}>, 'org.kicad.pcbcalculator.desktop': <{'position': <11>}>, 'org.kicad.pcbnew.desktop': <{'position': <12>}>, 'org.kicad.eeschema.desktop': <{'position': <13>}>, 'kitty.desktop': <{'position': <14>}>, 'base.desktop': <{'position': <15>}>, 'calc.desktop': <{'position': <16>}>, 'draw.desktop': <{'position': <17>}>, 'impress.desktop': <{'position': <18>}>, 'math.desktop': <{'position': <19>}>, 'startcenter.desktop': <{'position': <20>}>, 'writer.desktop': <{'position': <21>}>, 'org.gnome.Nautilus.desktop': <{'position': <22>}>, 'org.gnome.Music.desktop': <{'position': <23>}>}, {'netease-cloud-music.desktop': <{'position': <0>}>, 'nixos-manual.desktop': <{'position': <1>}>, 'Proton Experimental.desktop': <{'position': <2>}>, 'qq.desktop': <{'position': <3>}>, 'scrcpy.desktop': <{'position': <4>}>, 'scrcpy-console.desktop': <{'position': <5>}>, 'steam.desktop': <{'position': <6>}>, 'Steam Linux Runtime - Soldier.desktop': <{'position': <7>}>, 'org.telegram.desktop.desktop': <{'position': <8>}>, 'org.gnome.TextEditor.desktop': <{'position': <9>}>, 'thunderbird.desktop': <{'position': <10>}>, 'org.gnome.Tour.desktop': <{'position': <11>}>, 'code.desktop': <{'position': <12>}>, 'org.gnome.Epiphany.desktop': <{'position': <13>}>, 'wemeetapp.desktop': <{'position': <14>}>, 'wemeetapp-force-x11.desktop': <{'position': <15>}>, 'winetricks.desktop': <{'position': <16>}>, 'xterm.desktop': <{'position': <17>}>, 'org.gnome.Calendar.desktop': <{'position': <18>}>}]";
      disabled-extensions = [ "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "improvedosk@nick-shmyrev.dev" "screen-rotate@shyzus.github.io" "osktouchpad@francescocaracciolo.uno" "trayIconsReloaded@selfmade.pl" "topiconsfix@aleskva@devnullmail.com" "appindicatorsupport@rgcjonas.gmail.com" "forge@jmmaranan.com" "blur-my-shell@aunetx" "tiling-assistant@leleat-on-github" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" ];
      favorite-apps = [ "org.gnome.Console.desktop" "vivaldi-stable.desktop" "bitwarden.desktop" "org.telegram.desktop.desktop" "thunderbird.desktop" "Waydroid.desktop" "zotero.desktop" ];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "43.3";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

  };
}
