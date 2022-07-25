{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  boot.kernelParams = [ "acpi_backlight=vendor" "video.use_native_backlight=1" "hid_apple.fnmode=2" ];
  services.xserver.config = readFile ./xorg.conf;
  services.xserver = {
    enable = true;
    wacom.enable = true;
    videoDrivers = [ "nvidia" ];
    libinput.enable = true;
    desktopManager.runXdgAutostartIfNone = true; # fcitx5
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
  services.picom = {
    enable = true;
    experimentalBackends = true;
    backend = "glx";
    settings = {
      blur-method = "dual_kawase";
      blur-size = 12;
      corner-radius = 14;
      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
      ];
    };
  };
  fonts.fonts = with pkgs; [
    jetbrains-mono
    source-han-sans
  ];

  # from https://github.com/taffybar/taffybar/issues/403
  # resolve tray not showing in polybar
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
}