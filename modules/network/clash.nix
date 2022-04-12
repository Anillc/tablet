{ config, pkgs, lib, ... }:

with builtins;
with lib;

let
  sync-clash = pkgs.writeScript "sync-clash" ''
    export PATH=$PATH:${with pkgs; lib.strings.makeBinPath [
        wget gnused
    ]}
    ${config.sops.secrets.sync-clash.path}
    sed -i "0,/type: select/{s/type: select/type: url-test\n  url: http:\/\/google.com\n  interval: 300/}" /var/lib/clash/config.yaml
  '';
in {
  networking.proxy.default = "http://127.0.0.1:7890";
  sops.secrets.sync-clash = {
      sopsFile  = ./secrets.yaml;
      mode = "0700";
  };
  systemd.services.clash = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    preStart = "${sync-clash}";
    script = "${pkgs.clash}/bin/clash -d /var/lib/clash";
  };
}