{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  security.sudo.wheelNeedsPassword = false;
  environment.shells = [ pkgs.fish ];
  users.users.anillc = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$6$Gb5yWjYmsBX72y3Q$SAg7ym2VszDOiZw2Dmo.3R7fBAg3LHCqHcTkggNaNHOGnaaQLptoETbIVM2c4Ox2sxOZm6IC4anA9L5A3MDKk.";
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.anillc = import ./home.nix;
  };
  environment.persistence."/persist" = {
    users.anillc = {
      directories = [
        "temp"
        "Projects"
        "Downloads"
        "Documents"
        "Android"
        ".android"
        ".config/fcitx5"
        ".config/chromium"
        ".config/Code"
        ".config/Bitwarden"
        ".config/sops"
        ".config/discord"
        ".config/Element"
        ".config/VirtualBox"
        ".config/JetBrains"
        ".config/Logseq"
        ".config/icalingua"
        ".cache/netease-cloud-music"
        ".cache/nix-index"
        ".cache/nix"
        ".thunderbird"
        ".minecraft"
        ".mozilla"
        ".logseq"
        ".vscode"
        ".gnupg"
        ".local"
        ".ssh"
      ];
      files = [
        ".gitconfig"
        ".wakatime.cfg"
      ];
    };
  };
}