{ config, pkgs, lib, ... }:

with builtins;
with lib;

{
  networking.hostName = "duet";
  networking.networkmanager.enable = true;
  programs.clash-verge.enable = true;
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  services.tailscale.enable = true;
}
