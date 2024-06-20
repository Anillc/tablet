{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  security.pki.certificates = [ (builtins.readFile ./root.crt) ];
  security.sudo.wheelNeedsPassword = false;
  programs.fish.enable = true;
  users.users.anillc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "dialout" "networkmanager" ];
    shell = pkgs.fish;
    hashedPassword = "$6$Gb5yWjYmsBX72y3Q$SAg7ym2VszDOiZw2Dmo.3R7fBAg3LHCqHcTkggNaNHOGnaaQLptoETbIVM2c4Ox2sxOZm6IC4anA9L5A3MDKk.";
  };
  security.pam = {
    services.login = {
      rules.auth.oath.control = mkForce "sufficient";
      oathAuth = true;
    };
    oath = {
      enable = true;
      usersFile = config.sops.secrets.oath.path;
    };
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
  programs.kdeconnect.enable = true;
  environment.persistence."/persist" = {
    users.anillc = {
      directories = [
        ".android"
        ".arduino15"
        ".cache/coursier"
        ".cache/Google"
        ".cache/huggingface"
        ".cache/JetBrains"
        ".cache/nix-index"
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
        ".config/xournalpp"
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