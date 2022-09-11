{ pkgs, lib, ... }:

with builtins;
with lib;

{
  xsession = {
    enable = true;
    numlock.enable = true;
  };
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    script = "polybar example &";
    config = ./polybar.ini;
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
    keybindings = {
      "f1" = "launch --stdin-source=@screen_scrollback --type=overlay vim + -";
    };
  };
}