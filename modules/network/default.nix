{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  networking.hostName = "duet";
  networking.networkmanager.enable = true;
  services.v2raya.enable = true;
}
