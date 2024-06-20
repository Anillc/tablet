{ config, pkgs, lib, ... }: {
  sops = {
    age.keyFile = "/var/lib/sops.key";
    defaultSopsFile = ./secrets.yaml;
    secrets.oath = {};
  };
}
