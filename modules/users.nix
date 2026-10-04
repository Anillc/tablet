{
  users.users.anillc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "dialout" "networkmanager" "wireshark" "docker" "libvirtd" ];
    hashedPassword = "$6$Gb5yWjYmsBX72y3Q$SAg7ym2VszDOiZw2Dmo.3R7fBAg3LHCqHcTkggNaNHOGnaaQLptoETbIVM2c4Ox2sxOZm6IC4anA9L5A3MDKk.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmgw6CGq5fPlVdJc5DhgXzlW2GSimAd1xiRbEZWS0KG phone"
    ];
  };

  environment.persistence."/persist".users.anillc.directories = [
    ".cache"
    ".local"
    "Desktop"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Projects"
    "Public"
    "Templates"
    "Videos"
  ];

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
