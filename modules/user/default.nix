{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  security.sudo.wheelNeedsPassword = false;
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
        ".config/fcitx5"
        ".config/chromium"
        ".config/Code"
        ".config/keepassxc"
        ".config/sops"
        ".config/discord"
        ".config/Element"
        ".config/VirtualBox"
        ".cache/netease-cloud-music"
        ".minecraft"
        ".mozilla"
        ".vscode"
        ".gnupg"
        ".local"
        ".ssh"
      ];
      files = [
        ".gitconfig"
      ];
    };
  };
}