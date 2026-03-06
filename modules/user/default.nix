{ config, lib, ... }: {
  security.sudo.wheelNeedsPassword = false;
  users.users.anillc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "dialout" "networkmanager" "wireshark" "docker" ];
    hashedPassword = "$6$Gb5yWjYmsBX72y3Q$SAg7ym2VszDOiZw2Dmo.3R7fBAg3LHCqHcTkggNaNHOGnaaQLptoETbIVM2c4Ox2sxOZm6IC4anA9L5A3MDKk.";
  };
  security.pam = {
    services.login = {
      rules.auth.oath.control = lib.mkForce "sufficient";
      oathAuth = true;
    };
    oath = {
      enable = true;
      usersFile = config.sops.secrets.oath.path;
    };
  };
  time.timeZone = "Asia/Shanghai";
  virtualisation.podman.enable = true;
  virtualisation.docker.enable = true;
  environment.persistence."/persist" = {
    users.anillc = {
      directories = [
        ".cache/coursier"
        ".cache/nix"
        ".cache/pip"
        ".config/attic"
        ".config/Code"
        ".config/dconf"
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
    };
  };

  # activate home manager
  systemd.services.home-manager = {
    wantedBy = [ "multi-user.target" ];
    wants = [ "nix-daemon.socket" ];
    after = [ "nix-daemon.socket" ];
    before = [ "systemd-user-sessions.service" ];
    unitConfig.RequiresMountsFor = "/home/anillc";
    serviceConfig.User = "anillc";
    script = ''
      exec $HOME/.local/state/nix/profiles/home-manager/activate
    '';
  };
}
