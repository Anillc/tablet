{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  nixpkgs.config.allowUnfree = true;
  nix.binaryCaches = [  ];
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
    wget dmenu xmobar kitty tdesktop vscode chromium
    flameshot git firefox keepassxc ghc openjdk
    discord libreoffice nodejs yarn
    logseq thunderbird osu-lazer icalingua
    pkgs.inputs.nickcao.packages.${pkgs.system}.wemeet
    pkgs.inputs.nixos-cn.legacyPackages.${pkgs.system}.netease-cloud-music
    jetbrains.idea-community jetbrains.goland jetbrains.clion go_1_18 gcc
    nix-index clang cmake gnumake mtr android-studio
  ];
  environment.variables.QT_IM_MODULE = mkForce "ibus";
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