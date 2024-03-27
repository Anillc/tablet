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
      export MOZ_USE_XINPUT2=1
      alias pb="curl --data-binary @- https://pb.nichi.co/"
      alias s="systemctl"
    '';
    plugins = let
      p = with pkgs.fishPlugins; [ plugin-git done puffer ];
    in map (x: { name = x.pname; inherit (x) src; }) p;
  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
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
