{ pkgs, lib, ... }:

let
  folio-reset-extension = pkgs.stdenvNoCC.mkDerivation {
    name = "gnome-shell-extension-folio-reset";
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      dir=$out/share/gnome-shell/extensions/folio-reset@anillc
      mkdir -p "$dir"
      cp ${./folio-reset.js} "$dir/extension.js"
      cat >"$dir/metadata.json" <<EOF
      {
        "uuid": "folio-reset@anillc",
        "name": "Folio USB Reset",
        "description": "Reset the xHCI controller when the Duet 5 folio keyboard is not detected",
        "shell-version": ["${lib.versions.major pkgs.gnome-shell.version}"],
        "version": 1
      }
      EOF
      runHook postInstall
    '';
  };
in

{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    libinput.enable = true;
    iptsd = {
      enable = true;
      config.Touchscreen = {
        DisableOnStylus = true;
        DisableOnPalm = true;
      };
    };
  };
  programs.xwayland.enable = true;

  environment.systemPackages = lib.flip map (with pkgs.gnomeExtensions; [
    gjs-osk
    blur-my-shell appindicator
    kimpanel launch-new-instance screen-rotate gsconnect
  ]) (x: x.overrideAttrs (old: let
    version = pkgs.gnome-shell.version
      |> lib.split "\\."
      |> lib.flip lib.elemAt 0;
  in {
    postFixup = (old.postFixup or "") + ''
      FILE=$out/share/gnome-shell/extensions/*/metadata.json
      METADATA=$(cat $FILE)
      echo $METADATA | ${pkgs.jq}/bin/jq '."shell-version" += ["${version}"]' > $FILE
    '';
  })) ++ [ folio-reset-extension ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    source-han-sans
    font-awesome
  ] ++ lib.filter lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  systemd.tmpfiles.rules = [
    "d /var/lib/gdm/seat0/config              0700 gdm-greeter nogroup -"
    "L /var/lib/gdm/seat0/config/monitors.xml  -    -           -       - ${./monitors.xml}"
    "L /home/anillc/.config/monitors.xml       -    anillc      users   - ${./monitors.xml}"
  ];
  # gsconnect
  networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];

  environment.persistence."/persist".users.anillc.directories = [ ".config/dconf" ];
}
