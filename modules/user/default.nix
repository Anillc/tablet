{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  sops.age.keyFile = "/var/lib/sops.key";
  security.pki.certificates = [ (builtins.readFile ./root.crt) ];
  security.sudo.wheelNeedsPassword = false;
  environment.shells = [ pkgs.fish ];
  programs.fish.enable = true;
  users.users.anillc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "dialout" "networkmanager" ];
    shell = pkgs.fish;
    hashedPassword = "$6$Gb5yWjYmsBX72y3Q$SAg7ym2VszDOiZw2Dmo.3R7fBAg3LHCqHcTkggNaNHOGnaaQLptoETbIVM2c4Ox2sxOZm6IC4anA9L5A3MDKk.";
  };
  programs.adb.enable = true;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ ./home.nix ];
    users.anillc = {};
  };
  time.timeZone = "Asia/Shanghai";
  networking.firewall.enable = false;
  programs.vim.defaultEditor = true;
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];
  programs.nix-ld.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  programs.steam.enable = true;
  environment.persistence."/persist" = {
    users.anillc = {
      directories = [
        ".android"
        ".arduino15"
        ".cache/Google"
        ".cache/huggingface"
        ".cache/JetBrains"
        ".cache/nix-index"
        ".cache/netease-cloud-music"
        ".cache/nix"
        ".cache/pip"
        ".config/Bitwarden"
        ".config/Code"
        ".config/clash-verge"
        ".config/dconf"
        ".config/discord"
        ".config/Element"
        ".config/fcitx5"
        ".config/Google"
        ".config/JetBrains"
        ".config/kdeconnect"
        ".config/npm-token"
        ".config/QQ"
        ".config/sops"
        ".config/vivaldi"
        ".cargo"
        ".gnupg"
        ".gradle"
        ".local"
        ".minecraft"
        ".mozilla"
        ".ssh"
        ".thunderbird"
        ".vscode"
        ".wine"
        ".zotero"
        "Android"
        "Arduino"
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Projects"
        "Public"
        "Templates"
        "Videos"
        "Zotero"
      ];
      files = [
        ".gitconfig"
        ".wakatime.cfg"
      ];
    };
  };
}