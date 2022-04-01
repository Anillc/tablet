{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "an";
  networking.networkmanager.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.binaryCaches = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  nix = {
    package = pkgs.nixUnstable;
    nixPath = [ "nixpkgs=${pkgs.inputs.nixpkgs}" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  security.sudo.wheelNeedsPassword = false;
  users.users.anillc = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$6$Gb5yWjYmsBX72y3Q$SAg7ym2VszDOiZw2Dmo.3R7fBAg3LHCqHcTkggNaNHOGnaaQLptoETbIVM2c4Ox2sxOZm6IC4anA9L5A3MDKk.";
  };
  environment.systemPackages = with pkgs; [
    vim wget dmenu xmobar kitty
    tdesktop vscode chromium
    flameshot git firefox
    keepassxc
    ghc openjdk
    # discord
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.anillc = import ./home.nix;
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
  };
  fonts.fonts = with pkgs; [ jetbrains-mono ];

  nixpkgs.overlays = [(self: super: {
    haskellPackages = super.haskellPackages.override {
      overrides = hself: hsuper: {
        xmonad = hself.xmonad_0_17_0;
        xmonad-contrib = hself.xmonad-contrib_0_17_0;
        xmonad-extras = hself.xmonad-extras_0_17_0;
      };
    };
  })];
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
        src = ../files/xmonad.hs;
        bg = ../files/bg.png;
      });
    };
    # xrandrHeads = [
    #   {
    #     output = "HDMI-1";
    #     monitorConfig = ''
    #       Option "PreferredMode" "1920x1080"
    #       Option "Rotate" "right"
    #     '';
    #   }
    #   {
    #     output = "eDP-1";
    #     primary = true;
    #     monitorConfig = ''
    #       Option "PreferredMode" "2560x1440"
    #     '';
    #   }
    # ];
    extraConfig = ''
      Section "Extensions"
        Option "Composite" "Enable"
      EndSection
    '';
  };
  services.xserver.config = mkForce ''

      Section "ServerLayout"
          Identifier     "Layout0"
          Screen      0  "Screen0" 0 0
          InputDevice    "Keyboard0" "CoreKeyboard"
          InputDevice    "Mouse0" "CorePointer"
          Option         "Xinerama" "0"
      EndSection

      Section "InputDevice"
          # generated from default
          Identifier     "Mouse0"
          Driver         "mouse"
          Option         "Protocol" "auto"
          Option         "Device" "/dev/input/mice"
          Option         "Emulate3Buttons" "no"
          Option         "ZAxisMapping" "4 5"
      EndSection

      Section "InputDevice"
          # generated from default
          Identifier     "Keyboard0"
          Driver         "kbd"
      EndSection

      Section "Monitor"
          # HorizSync source: edid, VertRefresh source: edid
          Identifier     "Monitor0"
          VendorName     "Unknown"
          ModelName      "BOE Technology Group Co., Ltd"
          HorizSync       244.0 - 244.0
          VertRefresh     48.0 - 165.0
          Option         "DPMS"
      EndSection

      Section "Device"
          Identifier     "Device0"
          Driver         "nvidia"
          VendorName     "NVIDIA Corporation"
          BoardName      "NVIDIA GeForce RTX 3060 Laptop GPU"
      EndSection

      Section "Screen"
          Identifier     "Screen0"
          Device         "Device-nvidia[0]"
          Monitor        "Monitor0"
          DefaultDepth    24
          Option         "Stereo" "0"
          Option         "nvidiaXineramaInfoOrder" "DFP-5"
          # Option         "metamodes" "DP-4: nvidia-auto-select +1080+0, HDMI-0: nvidia-auto-select +0+0 {rotation=right}"
          Option         "metamodes" "DP-4: nvidia-auto-select +1080+0 {viewportin=1920x1080}, HDMI-0: nvidia-auto-select +0+0 {rotation=right}"
          Option         "SLI" "Off"
          Option         "MultiGPU" "Off"
          Option         "BaseMosaic" "off"
          SubSection     "Display"
              Depth       24
          EndSubSection
      EndSection
  '';
  # hardware.video.hidpi.enable = true;
  environment.variables = {
    # QT_SCALE_FACTOR = "1.5";
  };

  environment.persistence."/persist" = {
    directories = [
      "/var/lib"
      "/var/log"
      "/var/cache"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.anillc = {
      directories = [
        "temp"
        ".config/fcitx5"
        ".config/chromium"
        ".config/Code"
        ".config/keepassxc"
        ".minecraft"
        ".mozilla"
        ".vscode"
        ".local"
        ".ssh"
      ];
      files = [
        ".gitconfig"
      ];
    };
  };
  programs.command-not-found.enable = false;

  system.stateVersion = "21.11";
}
