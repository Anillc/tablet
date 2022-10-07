{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  imports = [
    # ./clash.nix
  ];
  networking.hostName = "an";
  networking.networkmanager.enable = true;
}