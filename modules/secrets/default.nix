{ config, pkgs, lib, ... }: {
  sops = {
    age.keyFile = "/var/lib/sops.key";
    defaultSopsFile = ./secrets.yaml;
    secrets.oath = {};
    secrets.tablet-backup-restic-repo = {};
    secrets.tablet-backup-restic-passwd = {};
    secrets.tablet-backup-restic-env = {};
  };
}
