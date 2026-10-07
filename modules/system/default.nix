{ config, lib, ... }:

{
  system.stateVersion = "22.05";
  time.timeZone = "Asia/Shanghai";

  # hardware
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable32Bit = true;
  hardware.sensor.iio.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # FIXME: systemd-inhibit --list  gnome-settings-daemon
  services.logind.settings.Login = {
    # powerKey = "suspend-then-hibernate";
    # suspendKey = "suspend-then-hibernate";
    HandlePowerKey = "hibernate";
    HandleSuspendKey = "hibernate";
  };
  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "1h";
  };

  # boot
  boot = {
    initrd.systemd.enable = true;
    initrd.luks.devices.root.device = "/dev/disk/by-uuid/a149a2ae-b7e1-4201-b978-e380c0acf6f4";
    resumeDevice = "/dev/mapper/root";
    kernelParams = [ "resume_offset=533760" "video=efifb" "fbcon=rotate:1" ];

    binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];
    extraModprobeConfig = ''
      options hid_apple fnmode=2
    '';

    # secure boot
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/persist/secureboot";
    };

  };

  # file systems
  fileSystems."/" = {
    fsType = "tmpfs";
    options = [ "defaults" "mode=755" ];
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/94F6-73BE";
    fsType = "vfat";
  };
  fileSystems."/nix" = {
    device = "/dev/mapper/root";
    fsType = "btrfs";
    options = [ "subvol=nix" "noatime" "compress-force=zstd" "space_cache=v2" ];
  };
  fileSystems."/persist" = {
    device = "/dev/mapper/root";
    fsType = "btrfs";
    options = [ "subvol=persist" "noatime" "compress-force=zstd" "space_cache=v2" ];
    neededForBoot = true;
  };
  fileSystems."/swap" = {
    device = "/dev/mapper/root";
    fsType = "btrfs";
    options = [ "subvol=swap" "noatime" "compress-force=zstd" "space_cache=v2" ];
    neededForBoot = true;
  };
  fileSystems."/tmp" = {
    device = "/dev/mapper/root";
    fsType = "btrfs";
    options = [ "subvol=tmp" "noatime" "compress-force=zstd" "space_cache=v2" ];
    neededForBoot = true;
  };
  swapDevices = [{ device = "/swap/swapfile"; }];

  environment.persistence."/persist" = {
    directories = [
      "/var/lib"
      "/var/log"
      "/var/cache"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  # security
  sops.secrets.oath = {
    sopsFile = ./secrets.yaml;
  };
  security.sudo.wheelNeedsPassword = false;
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
}
