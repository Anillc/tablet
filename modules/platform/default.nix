{ config, lib, pkgs, modulesPath, ... }:

{
  environment.persistence."/persist" = {
    directories = [
      "/var/lib"
      "/var/log"
      "/var/cache"
      "/etc/NetworkManager"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  sound.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.pulseaudio.enable = true;
  services.pipewire.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.driSupport32Bit = true;
  system.stateVersion = "22.05";
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];
    initrd.kernelModules = [ "tpm" "tpm_tis" "tpm_crb" ];
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" ];
    initrd.luks.devices.root.device = "/dev/disk/by-uuid/a149a2ae-b7e1-4201-b978-e380c0acf6f4";
    initrd.systemd.enable = true;
    bootspec.enable = true;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/persist/secureboot";
    };
    resumeDevice = "/dev/mapper/root";
    kernelParams = [ "resume_offset=533760" "video=efifb" "fbcon=rotate:1" ];
    loader.efi.canTouchEfiVariables = true;
  };
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
  #fileSystems."/tmp" = {
  #  device = "/dev/mapper/root";
  #  fsType = "btrfs";
  #  options = [ "subvol=tmp" "noatime" "compress-force=zstd" "space_cache=v2" ];
  #  neededForBoot = true;
  #};
}
