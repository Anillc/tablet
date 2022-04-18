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
}