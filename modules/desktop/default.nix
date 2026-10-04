{ pkgs, lib, ... }:

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
    blur-my-shell appindicator disable-gestures-2021
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
  }));

  fonts.packages = with pkgs; [
    jetbrains-mono
    source-han-sans
    font-awesome
  ] ++ lib.filter lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  systemd.tmpfiles.rules = [
    "L /run/gdm/.config/monitors.xml     -      -     - - ${./monitors.xml}"
    "L /home/anillc/.config/monitors.xml - anillc users - ${./monitors.xml}"
  ];
  # gsconnect
  networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];

  environment.persistence."/persist".users.anillc.directories = [ ".config/dconf" ];
}
