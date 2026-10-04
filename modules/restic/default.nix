{ config, ... }:

{
  sops.secrets = {
    restic-persist-repo.sopsFile = ./secrets.yaml;
    restic-persist-pwd.sopsFile = ./secrets.yaml;
    restic-persist-env.sopsFile = ./secrets.yaml;
  };

  services.restic.backups.persist = {
    initialize = true;
    repositoryFile = config.sops.secrets.restic-persist-repo.path;
    passwordFile = config.sops.secrets.restic-persist-pwd.path;
    environmentFile = config.sops.secrets.restic-persist-env.path;
    paths = [ "/persist" ];
    extraBackupArgs = [
      "--one-file-system"
      "--exclude-caches"
      "--no-scan"
      "--retry-lock 2h"
    ];
    timerConfig = {
      OnCalendar = "daily";
      RandomizedDelaySec = "4h";
      FixedRandomDelay = true;
      Persistent = true;
    };
  };
}
