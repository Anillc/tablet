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
    wget dmenu xmobar kitty
    tdesktop vscode chromium
    flameshot git firefox
    keepassxc
    ghc openjdk
    discord
    libreoffice
    nodejs yarn
    element-desktop
    pkgs.inputs.nickcao.packages.${pkgs.system}.wemeet
    pkgs.inputs.nixos-cn.legacyPackages.${pkgs.system}.netease-cloud-music
  ];

  # nixpkgs.overlays = [(self: super: {
  #   haskellPackages = super.haskellPackages.override {
  #     overrides = hself: hsuper: {
  #       xmonad = hself.xmonad_0_17_0;
  #       xmonad-contrib = hself.xmonad-contrib_0_17_0;
  #       xmonad-extras = hself.xmonad-extras_0_17_0;
  #     };
  #   };
  # })];
}