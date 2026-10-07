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

  # This doesn't work for gnome. Keep this for non-gnome sessions.
  services.logind.settings.Login = {
    HandlePowerKey = "suspend-then-hibernate";
    HandleSuspendKey = "suspend-then-hibernate";
  };
  systemd.services."systemd-suspend".serviceConfig.ExecStart = [
    "" "${config.systemd.package}/lib/systemd/systemd-sleep suspend-then-hibernate"
  ];
  systemd.sleep.settings.Sleep.HibernateDelaySec = "1h";

  systemd.services.duet-folio-rebind = {
    description = "Re-probe the Duet 5 folio keyboard/touchpad after resume";
    after = [ "suspend.target" ];
    wantedBy = [ "suspend.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      set -euo pipefail
      dev=/sys/bus/usb/devices/1-3
      hid=/sys/bus/usb/drivers/usbhid

      for _ in {1..20}; do
        [[ -e "$dev:1.1" ]] && break
        sleep 1
      done

      echo 1-3:1.0 > "$hid/bind" 2>/dev/null || true
      echo 1-3:1.1 > "$hid/bind" 2>/dev/null || true
    '';
  };

  # boot
  boot = {
    initrd.systemd.enable = true;
    initrd.luks.devices.root.device = "/dev/disk/by-uuid/a149a2ae-b7e1-4201-b978-e380c0acf6f4";
    resumeDevice = "/dev/mapper/root";
    kernelParams = [
      "resume_offset=533760"
      "video=efifb"
      "fbcon=rotate:1"
      # keyboard is not high speed device
      "usbcore.quirks=17ef:6139:i"
    ];

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
      oathAuth = true;
      rules.auth.oath = {
        control = lib.mkForce "sufficient";
        order = 13200;
      };
    };
    oath.usersFile = config.sops.secrets.oath.path;
  };
}
