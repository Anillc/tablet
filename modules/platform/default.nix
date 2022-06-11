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
  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "22.05";
  boot = {
    kernelModules = [ "kvm-intel" ];
    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    initrd.luks.devices.root.device = "/dev/disk/by-uuid/58d02335-f2ec-4b7b-bcfe-9aa6f54c427d";
    # initrd.systemd = {
    #   enable = true;
    #   emergencyAccess = true;
    #   storePaths = [
    #     "${config.boot.initrd.systemd.package}/lib/systemd/systemd-cryptsetup"
    #   ];
    #   contents = {
    #     "/etc/crypttab".text = ''
    #       root /dev/nvme0n1p2 - fido2-device=auto
    #     '';
    #   };
    # };
    resumeDevice = "/dev/mapper/root";
    kernelParams = [ "resume_offset=1127116" ];
    tmpOnTmpfs = true;
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
      };
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
    };
  };
  swapDevices = [{ device = "/swap/swapfile"; }];
  fileSystems."/" = {
    fsType = "tmpfs";
    options = [ "defaults" "mode=755" ];
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C2E7-1545";
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
}
