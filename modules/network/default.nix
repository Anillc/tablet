{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  imports = [
    # ./clash.nix
  ];
  networking.hostName = "duet";
  networking.networkmanager.enable = true;
}
