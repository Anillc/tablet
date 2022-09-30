{ config, pkgs, lib, inputs, ... }:

with builtins;
with lib;

let
  interface = "wlo1";
in {
  networking.nat = {
    enable = true;
    externalInterface = interface;
    internalInterfaces = [ "nvrf" "wlovrf" ];
  };
  systemd.services.nvrf = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    bindsTo = [ "container@config.service" ];
    path = with pkgs; [ iproute2 dhcpcd gnused ];
    serviceConfig = {
      Type = "oneshot";
      Restart = "on-failure";
      RemainAfterExit = true;
    };
    script = ''
      ip address add 192.168.11.1/24 dev wlovrf
      ip link add nvrf type vrf table 10
      ip link set nvrf up
      GATEWAY=$(dhcpcd -1 -z ${interface} 2>&1 | sed -rn 's/^${interface}: adding default route via ([^:]+)$/\1/p')
      if [[ -z "$GATEWAY" ]]; then
        exit 1
      fi
      ip link set wlovrf vrf nvrf
      ip link set ${interface} vrf nvrf
      ip route replace default via $GATEWAY dev ${interface} onlink table 10
    '';
    postStop = ''
      ip link set ${interface} nomaster || true
      ip link del nvrf || true
      ip address del 192.168.11.1/24 dev wlovrf || true
    '';
  };
  containers.config = {
    autoStart = true;
    privateNetwork = true;
    extraVeths.wlovrf = {};
    extraVeths.eth = {};
    config = let
      inherit (inputs.config.systems) local;
    in {
      _module.args = local.specialArgs;
      imports = local.modules;
      systemd.services.setup = {
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" ];
        path = with pkgs; [ iproute2 ];
        script = ''
          ip address add 192.168.11.2/24 dev wlovrf
          ip route replace default via 192.168.11.1
          ip link set eth master br11
        '';
      };
    };
  };
}