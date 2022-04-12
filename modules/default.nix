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
}
