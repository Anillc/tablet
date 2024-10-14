{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  nixpkgs.config.allowUnfree = true;
  nix = {
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
      trusted-users = [ "@wheel" ];
    };
  };
  programs.command-not-found.enable = false;
  programs.fish.enable = true;
  programs.adb.enable = true;
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    (callPackage ./vscode.nix {})
    (agda.withPackages (p: [ p.standard-library p.cubical ]))
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
    ((vivaldi.override {
      inherit vivaldi-ffmpeg-codecs widevine-cdm;
      commandLineArgs = "--ozone-platform=wayland --gtk-version=4 --disable-features=WaylandFractionalScaleV1";
      proprietaryCodecs = true;
      enableWidevine = true;
    }).overrideAttrs (old: {
      buildPhase = old.buildPhase + ''
        for f in chrome_crashpad_handler vivaldi-bin vivaldi-sandbox; do
          patchelf --add-rpath "${pkgs.gtk4}/lib" opt/vivaldi/$f
        done
      '';
    }))
    agda-language-server
    android-studio
    bitwarden
    cabal-install
    clang-tools
    cmake
    dig
    discord
    element-desktop
    feishu
    ffmpeg-full
    file
    firefox
    gcc
    ghc
    git
    gnome-network-displays
    gnumake
    haskell-language-server
    htop
    iperf
    jetbrains.idea-community
    libclang
    libnotify
    llvm
    meson
    mill
    mtr
    ncdu
    nix-index
    nodejs
    ninja
    nur.repos.linyinfeng.wemeet
    openjdk
    tdesktop
    qq
    ripgrep
    sbctl
    scala
    scrcpy
    socat
    thunderbird
    unar
    wget
    whois
    wine
    winetricks
    wl-clipboard
    xournalpp
    yarn
    zotero_7
  ];
}
