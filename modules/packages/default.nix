{ config, pkgs, lib, ... }:

with builtins;
with lib;

let
  share = pkgs.callPackage ./share.nix {};
in {
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixUnstable;
    nixPath = [ "nixpkgs=${pkgs.inputs.nixpkgs}" ];
    registry.p.flake = pkgs.inputs.self;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://anillc.cachix.org"
      ];
      trusted-public-keys = [
        "anillc.cachix.org-1:VmWDYKHoDiT0CKs+6daDcTz3Ur+gkw4k0kcHIeF6dF8="
      ];
    };
  };
  programs.command-not-found.enable = false;
  environment.systemPackages = with pkgs; [
    (callPackage ./vscode.nix {})
    (rust-bin.nightly.latest.default.override {
      extensions = ["rust-src"];
    })
    tdesktop discord element-desktop qq
    wget rofi kitty chromium
    flameshot git firefox bitwarden openjdk
    libreoffice nodejs yarn thunderbird
    nur.repos.linyinfeng.wemeet
    pkgs.inputs.nixos-cn.legacyPackages.${pkgs.system}.netease-cloud-music
    jetbrains.idea-community gcc
    nix-index clang-tools cmake gnumake mtr android-studio
    xorg.xbacklight xorg.xmodmap scrcpy libnotify
    matlab-shell file libclang
    haskell-language-server cabal-install ghc
    wine winetricks kicad go gopls
    mtr dig unar iperf htop socat ncdu ripgrep
  ] ++ share;
  nixpkgs.overlays = [(self: super: {
    picom = super.picom.overrideAttrs (x: {
      src = pkgs.fetchFromGitHub {
        repo = "picom";
        owner = "ibhagwan";
        rev = "c4107bb6cc17773fdc6c48bb2e475ef957513c7a";
        sha256 = "sha256-1hVFBGo4Ieke2T9PqMur1w4D0bz/L3FAvfujY9Zergw=";
      };
    });
  })];
}