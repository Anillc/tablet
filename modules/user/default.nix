{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  security.sudo.wheelNeedsPassword = false;
  users.users.anillc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "dialout" "networkmanager" "wireshark" ];
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
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ ./home.nix ];
    users.anillc = {};
  };
  time.timeZone = "Asia/Shanghai";
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  environment.persistence."/persist" = {
    users.anillc = {
      directories = [
        ".android"
        ".cache/coursier"
        ".cache/Google"
        ".cache/huggingface"
        ".cache/JetBrains"
        ".cache/nix-index"
        ".cache/nix"
        ".cache/pip"
        ".config/attic"
        ".config/Bitwarden"
        ".config/Code"
        ".config/dconf"
        ".config/discord"
        ".config/Element"
        ".config/fcitx5"
        ".config/Google"
        ".config/JetBrains"
        ".config/LarkShell"
        ".config/npm-token"
        ".config/QQ"
        ".config/sops"
        ".config/vivaldi"
        ".config/xournalpp"
        ".cargo"
        ".gnupg"
        ".gradle"
        ".kube"
        ".local"
        ".minecraft"
        ".mozilla"
        ".ssh"
        ".thunderbird"
        ".vscode"
        ".wine"
        ".zotero"
        "Android"
        "Desktop"
        "Documents"
        "Downloads"
        "go"
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