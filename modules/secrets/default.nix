{ config, pkgs, lib, ... }: {
  sops = {
    age.keyFile = "/var/lib/sops.key";
    defaultSopsFile = ./secrets.yaml;
    secrets.oath = {};
    secrets.restic-persist-repo = {};
    secrets.restic-persist-pwd = {};
    secrets.restic-persist-env = {};
  };
}
