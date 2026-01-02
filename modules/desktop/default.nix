{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  programs.xwayland.enable = true;
  services.libinput.enable = true;
  services.iptsd = {
    enable = true;
    config.Touchscreen = {
      DisableOnStylus = true;
      DisableOnPalm = true;
    };
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-pinyin-zhwiki
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-minecraft
    ];
  };
  fonts.packages = with pkgs; [
    jetbrains-mono
    source-han-sans
    font-awesome
  ] ++ filter isDerivation (attrValues pkgs.nerd-fonts);
  systemd.tmpfiles.rules = [
    "L /run/gdm/.config/monitors.xml     -      -     - - ${./monitors.xml}"
    "L /home/anillc/.config/monitors.xml - anillc users - ${./monitors.xml}"
  ];
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
  # gsconnect
  networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
}
