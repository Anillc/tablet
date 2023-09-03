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
          rev = "0d597a23ce2e9a067131effca5aeb1a1068de0d0";
          sha256 = "sha256-MfrRQdcj7UtIUgtqKjt4lqFLpA6YZgKjE03VaaypNzE=";
        };
      }
      {
        name = "done";
        src = pkgs.fetchFromGitHub {
          owner = "franciscolourenco";
          repo = "done";
          rev = "d6abb267bb3fb7e987a9352bc43dcdb67bac9f06";
          sha256 = "sha256-6oeyN9ngXWvps1c5QAUjlyPDQwRWAoxBiVTNmZ4sG8E=";
        };
      }
      {
        name = "puffer";
        src = pkgs.fetchFromGitHub {
          owner = "nickeb96";
          repo = "puffer-fish";
          rev = "fd0a9c95da59512beffddb3df95e64221f894631";
          sha256 = "sha256-aij48yQHeAKCoAD43rGhqW8X/qmEGGkg8B4jSeqjVU0=";
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
  xdg = {
    enable = true;
    mimeApps = let
      vivaldi = {
        "text/html" = "vivaldi-stable.desktop";
        "x-scheme-handler/http" = "vivaldi-stable.desktop";
        "x-scheme-handler/https" = "vivaldi-stable.desktop";
        "application/pdf" = "vivaldi-stable.desktop";
        "application/xhtml+xml" = "vivaldi-stable.desktop";
      };
    in {
      enable = true;
      associations.added = vivaldi;
      defaultApplications = vivaldi;
    };
  };
}
