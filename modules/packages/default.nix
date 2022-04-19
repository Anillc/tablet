{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  nixpkgs.config.allowUnfree = true;
  nix.binaryCaches = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  nix = {
    package = pkgs.nixUnstable;
    nixPath = [ "nixpkgs=${pkgs.inputs.nixpkgs}" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  programs.command-not-found.enable = false;
  environment.systemPackages = with pkgs; [
    wget dmenu xmobar kitty tdesktop vscode chromium
    flameshot git firefox keepassxc ghc openjdk
    discord libreoffice nodejs yarn
    logseq
    pkgs.inputs.nickcao.packages.${pkgs.system}.wemeet
    pkgs.inputs.nixos-cn.legacyPackages.${pkgs.system}.netease-cloud-music
    jetbrains.idea-community jetbrains.goland go_1_18 clang gcc
  ];
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