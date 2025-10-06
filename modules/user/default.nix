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
        ".cache/coursier"
        ".cache/huggingface"
        ".cache/nix-index"
        ".cache/nix"
        ".cache/pip"
        ".config/attic"
        ".config/Code"
        ".config/dconf"
        ".config/fcitx5"
        ".config/LarkShell"
        ".config/npm-token"
        ".config/QQ"
        ".config/sops"
        ".config/vivaldi"
        ".config/xournalpp"
        ".cargo"
        ".gnupg"
        ".kube"
        ".local"
        ".ssh"
        ".thunderbird"
        ".vscode"
        ".zotero"
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