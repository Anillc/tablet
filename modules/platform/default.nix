{ config, lib, pkgs, modulesPath, ... }:

{
  environment.persistence."/persist" = {
    directories = [
      "/var/lib"
      "/var/log"
      "/var/cache"
      "/etc/NetworkManager"
      "/etc/v2raya"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
  services.restic.backups.persist = {
    initialize = true;
    repository = "rest:http://lux.a:8081/tablet";
    passwordFile = config.sops.secrets.tablet-backup-restic-passwd.path;
    paths = [ "/persist" ];
    extraBackupArgs = [
      "--one-file-system"
      "--exclude-caches"
      "--no-scan"
      "--retry-lock 2h"
    ];
    timerConfig = {
      OnCalendar = "daily";
      RandomizedDelaySec = "4h";
      FixedRandomDelay = true;
      Persistent = true;
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.pipewire.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable32Bit = true;
  hardware.sensor.iio.enable = true;
  system.stateVersion = "22.05";
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];
    kernelModules = [ "kvm-intel" "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    initrd.kernelModules = [ "tpm" "tpm_tis" "tpm_crb" ];
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" ];
    initrd.luks.devices.root.device = "/dev/disk/by-uuid/a149a2ae-b7e1-4201-b978-e380c0acf6f4";
    initrd.systemd.enable = true;
    # enabled by default
    # bootspec.enable = true;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/persist/secureboot";
    };
    resumeDevice = "/dev/mapper/root";
    kernelParams = [ "resume_offset=533760" "video=efifb" "fbcon=rotate:1" ];
    loader.efi.canTouchEfiVariables = true;
  };
  # FIXME: systemd-inhibit --list  gnome-settings-daemon
  services.logind = {
    # powerKey = "suspend-then-hibernate";
    # suspendKey = "suspend-then-hibernate";
    powerKey = "hibernate";
    suspendKey = "hibernate";
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';
  swapDevices = [{ device = "/swap/swapfile"; }];
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
}
