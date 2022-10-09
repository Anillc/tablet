{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  sops.age.keyFile = "/var/lib/sops.key";
  security.pki.certificates = [ (builtins.readFile ./root.crt) ];
  security.sudo.wheelNeedsPassword = false;
  environment.shells = [ pkgs.fish ];
  users.users.anillc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" ];
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
  virtualisation.virtualbox.host.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  powerManagement.powertop.enable = true;
  programs.kdeconnect.enable = true;
  programs.steam.enable = true;
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
        ".config/Google"
        ".config/kdeconnect"
        ".cache/netease-cloud-music"
        ".cache/nix-index"
        ".cache/nix"
        ".cache/huggingface"
        ".cache/pip"
        ".thunderbird"
        ".minecraft"
        ".mozilla"
        ".vscode"
        ".gnupg"
        ".local"
        ".wine"
        ".ssh"
      ];
      files = [
        ".gitconfig"
        ".wakatime.cfg"
      ];
    };
  };
}