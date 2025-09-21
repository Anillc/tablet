{ config, pkgs, lib, inputs, ... }:

with builtins;
with lib;

{
  nixpkgs.config.allowUnfree = true;
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    registry.p.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations pipe-operators
    '';
    settings = {
      trusted-users = [ "@wheel" ];
      substituters = mkBefore [ "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store" ];
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
        "wasm32-wasip1"
        "wasm32-wasip1-threads"
        "wasm32-wasip2"
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
    android-studio
    attic-client
    bitwarden
    cabal-install
    cargo-expand
    chromium
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
    go
    haskell-language-server
    htop
    iperf
    jetbrains.idea-community
    k9s
    kubectl
    kubernetes-helm
    libclang
    libnotify
    llvm
    meson
    mesonlsp
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
