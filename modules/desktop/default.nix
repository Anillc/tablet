{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  services.xserver = {
    enable = true;
    wacom.enable = true;
    libinput.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  services.gnome.tracker.enable = false;
  services.gnome.tracker-miners.enable = false;
  programs.xwayland.enable = true;
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
  };
  fonts.packages = with pkgs; [
    jetbrains-mono
    source-han-sans
  ];
  home-manager.sharedModules = [
    # ./home.nix
  ];
  systemd.tmpfiles.rules = [
    "L /run/gdm/.config/monitors.xml     -      -     - - ${./monitors.xml}"
    "L /home/anillc/.config/monitors.xml - anillc users - ${./monitors.xml}"
  ];
}
