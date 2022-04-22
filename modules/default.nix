{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  imports = [
    ./platform
    ./desktop
    ./network
    ./packages
    ./user
  ];
  sops.age.keyFile = "/var/lib/sops.key";
  time.timeZone = "Asia/Shanghai";
  networking.firewall.enable = false;
  programs.vim.defaultEditor = true;
  virtualisation.virtualbox.host.enable = true;
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  nix.extraOptions = ''
    extra-platforms = aarch64-linux i686-linux
  '';
  nix.sandboxPaths = [ "/run/binfmt" "${pkgs.qemu}" ];
  boot.binfmt.registrations = {
    aarch64 = {
      interpreter = "${pkgs.qemu}/bin/qemu-aarch64";
      magicOrExtension = ''\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7\x00'';
      mask = ''\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\x00\xff\xfe\xff\xff\xff'';
    };
  };
}
