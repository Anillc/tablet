{ pkgs, lib, ... }:

with builtins;
with lib;

{
  xsession = {
    enable = true;
    numlock.enable = true;
    initExtra = "${pkgs.picom}/bin/picom --experimental-backends --config ${pkgs.writeText "picom.conf" ''
      blur-method = "dual_kawase";
      backend = "glx";
      corner-radius = 7;
      rounded-corners-exclude = [
        "window_type = 'dock'",
        "window_type = 'desktop'",
      ];
    ''} &";
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
      background = "#000000";
      background_opacity = "0.4";
    };
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fish.enable = true;
  programs.starship.enable = true;
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
