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
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
}
