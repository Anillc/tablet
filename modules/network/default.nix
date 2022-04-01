{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  networking.hostName = "an";
  networking.networkmanager.enable = true;
}