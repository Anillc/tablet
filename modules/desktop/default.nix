{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  boot.kernelParams = [ "acpi_backlight=vendor" "video.use_native_backlight=1" "hid_apple.fnmode=2" ];
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = true;
  services.xserver = {
    enable = true;
    wacom.enable = true;
    dpi = 180;
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
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  services.xrdp.enable = true;
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
  };
  services.picom = {
    enable = true;
    # experimentalBackends = true;
    backend = "glx";
    settings = {
      blur-method = "dual_kawase";
      blur-size = 12;
      # corner-radius = 7;
      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'Dunst'"
      ];
    };
  };
  fonts.fonts = with pkgs; [
    jetbrains-mono
    source-han-sans
  ];

  home-manager.sharedModules = [
    ./home.nix
  ];

  # from https://github.com/taffybar/taffybar/issues/403
  # resolve tray not showing in polybar
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
}
