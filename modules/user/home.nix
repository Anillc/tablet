{ pkgs, lib, ... }:

with builtins;
with lib;

{
  home.stateVersion = "22.05";
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fish ={
    enable = true;
    shellInit = ''
      export TERM=xterm
      alias pb="curl --data-binary @- https://pb.nichi.co/"
      alias s="systemctl"
      __git.init
    '';
    plugins = [
      {
        name = "git";
        src = pkgs.fetchFromGitHub {
          owner = "jhillyerd";
          repo = "plugin-git";
          rev = "cc5999fa296c18105fb62f1637deec1d12454129";
          sha256 = "sha256-NaDZLmktuwlYxxzwDoVKgd8bEY+Wy9b2Qaz0CTf8V/Q=";
        };
      }
    ];
  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.gpg.enable = true;
  services.gpg-agent.enable = true;
  services.dunst = {
    enable = true;
    settings.global = {
      transparency = 40;
      font = "JetBrains Mono";
      background = "#282a2e";
      frame_width = 0;
      width = 500;
    };
  };
}
