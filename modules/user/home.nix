{ pkgs, lib, ... }:

with builtins;
with lib;

{
  xsession = {
    enable = true;
    numlock.enable = true;
    # initExtra = "${pkgs.picom}/bin/picom --experimental-backends --config ${pkgs.writeText "picom.conf" ''
    #   blur-method = "dual_kawase";
    #   backend = "glx";
    #   corner-radius = 7;
    #   rounded-corners-exclude = [
    #     "window_type = 'dock'",
    #     "window_type = 'desktop'",
    #   ];
    # ''} &";
  };
  programs.xmobar = {
    enable = true;
    extraConfig = builtins.readFile ./xmobar.conf;
  };
  programs.kitty = {
    enable = true;
    font = {
      name = "jetbrains mono";
      size = 12;
    };
    settings = {
      background = "#111111";
      background_opacity = "0.8";
    };
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fish ={
    enable = true;
    shellInit = ''
      export TERM=xterm
      alias pb="curl --data-binary @- https://pb.nichi.co/"
    '';
    plugins = [
      {
        name = "git";
        src = pkgs.fetchFromGitHub {
          owner = "jhillyerd";
          repo = "plugin-git";
          rev = "2a3e35c05bdc5b9005f917d5281eb866b2e13104";
          sha256 = "sha256-tWiGIB6yHfZ+QSNJrahHxRQCIOaOlSNFby4bGIOIwic=";
        };
      }
    ];
  };
  programs.starship.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent.enable = true;
  services.trayer = {
    enable = true;
    settings = {
      monitor = 1;
      width = 7;
      height = 32;
      edge = "top";
      align = "right";
      transparent = true;
      alpha = 0;
      tint = "0x555555";
      margin = 10;
      iconspacing = 10;
    };
  };
}
