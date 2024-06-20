{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  services.xserver = {
    enable = true;
    wacom.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  services.gnome.tracker.enable = false;
  services.gnome.tracker-miners.enable = false;
  programs.xwayland.enable = true;
  services.libinput.enable = true;
  services.iptsd = {
    enable = true;
    config.Touch = {
      DisableOnStylus = true;
      DisableOnPalm = true;
    };
  };
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
  };
  fonts.packages = with pkgs; [
    jetbrains-mono
    source-han-sans
    font-awesome
    nerdfonts
  ];
  home-manager.sharedModules = [
    ./dconf.nix
  ];
  systemd.tmpfiles.rules = [
    "L /run/gdm/.config/monitors.xml     -      -     - - ${./monitors.xml}"
    "L /home/anillc/.config/monitors.xml - anillc users - ${./monitors.xml}"
  ];
  environment.systemPackages = lib.flip map (with pkgs.gnomeExtensions; [
    gjs-osk blur-my-shell appindicator disable-gestures-2021
    kimpanel launch-new-instance screen-rotate
  ]) (x: x.overrideAttrs (old: let
    version = "46";
  in {
    postPatch = (old.postPatch or "") + ''
      METADATA=$(cat metadata.json)
      echo $METADATA | ${pkgs.jq}/bin/jq '."shell-version" += ["${version}"]' > metadata.json
    '';
  }));
}
