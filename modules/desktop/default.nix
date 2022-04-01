{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  boot.kernelParams = [ "acpi_backlight=vendor" "video.use_native_backlight=1" "hid_apple.fnmode=2" ];
  services.xserver.config = readFile ./xorg.conf;
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    libinput.enable = true;
    displayManager = {
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "anillc";
      };
    };
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = builtins.readFile (pkgs.substituteAll {
        inherit (pkgs) feh;
        src = ./xmonad.hs;
        bg = ./bg.png;
      });
    };
  };
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
  };
  fonts.fonts = with pkgs; [ jetbrains-mono ];
}