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
      experimental-features = nix-command flakes ca-derivations
    '';
    settings = {
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://anillc.cachix.org"
        "https://cache.ngi0.nixos.org"
      ];
      trusted-public-keys = [
        "anillc.cachix.org-1:VmWDYKHoDiT0CKs+6daDcTz3Ur+gkw4k0kcHIeF6dF8="
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
      ];
    };
  };
  programs.command-not-found.enable = false;
  programs.clash-verge = {
    enable = true;
    tunMode = true;
  };
  environment.systemPackages = with pkgs; [
    (callPackage ./vscode.nix {})
    (rust-bin.nightly.latest.default.override {
      extensions = ["rust-src"];
      targets = [
        "x86_64-unknown-linux-gnu"
        "x86_64-unknown-linux-musl"
        "x86_64-unknown-uefi"
        "riscv64gc-unknown-linux-gnu"
        "wasm32-wasi"
        "wasm32-unknown-unknown"
      ];
    })
    tdesktop discord element-desktop qq
    wget kitty vivaldi
    git firefox bitwarden openjdk
    libreoffice nodejs yarn thunderbird
    nur.repos.linyinfeng.wemeet
    pkgs.inputs.nixos-cn.legacyPackages.${pkgs.system}.netease-cloud-music
    jetbrains.idea-community gcc
    nix-index clang-tools llvm cmake gnumake mtr android-studio
    xorg.xbacklight xorg.xmodmap scrcpy libnotify
    file libclang
    haskell-language-server cabal-install ghc
    wine winetricks kicad go gopls
    mtr dig unar iperf htop socat ncdu ripgrep
    nil freerdp ffmpeg-full
    sbctl arduino
  ] ++ share;
}
