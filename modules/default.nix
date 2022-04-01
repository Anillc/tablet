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
}
