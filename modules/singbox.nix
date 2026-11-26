let
  tproxy-port = 7895;
  home-port = 7897;
  mark = 1;
  table = 1000;
  direct-mark = 2;
in {
  networking.nftables.tables.singbox_tproxy = {
    family = "inet";
    content = ''
      set bogons_v4 {
        type ipv4_addr
        flags interval
        elements = {
          0.0.0.0/8, 10.0.0.0/8, 100.64.0.0/10, 127.0.0.0/8,
          169.254.0.0/16, 172.16.0.0/12, 192.0.2.0/24, 192.88.99.0/24,
          192.168.0.0/16, 198.18.0.0/15, 198.51.100.0/24, 203.0.113.0/24,
          224.0.0.0/4, 240.0.0.0/4
        }
      }
      set bogons_v6 {
        type ipv6_addr
        flags interval
        elements = {
          ::/8, 0100::/64, 2001:2::/48, 2001:10::/28, 2001:db8::/32,
          2002::/16, 3ffe::/16, fc00::/7, fe80::/10, fec0::/10, ff00::/8
        }
      }
      chain output {
        type route hook output priority 100; policy accept;
        ct mark ${toString direct-mark} return
        fib daddr type local return
        ip daddr 10.11.0.0/16 meta mark set ${toString mark} return
        ip6 daddr fd11::/16 meta mark set ${toString mark} return
        ip daddr @bogons_v4 udp dport != 53 return
        ip daddr @bogons_v4 tcp dport != 53 return
        ip6 daddr @bogons_v6 udp dport != 53 return
        ip6 daddr @bogons_v6 tcp dport != 53 return
        meta mark != 0 return
        meta l4proto { tcp, udp } meta mark set ${toString mark}
      }
      chain prerouting {
        type filter hook prerouting priority -50; policy accept;
        fib daddr type local return
        ip daddr 10.11.0.0/16 meta l4proto { tcp, udp } meta mark set ${toString mark} tproxy ip to 127.0.0.1:${toString tproxy-port} accept
        ip6 daddr fd11::/16 meta nfproto ipv6 meta l4proto { tcp, udp } meta mark set ${toString mark} tproxy ip6 to [::1]:${toString tproxy-port} accept
        meta mark ${toString mark} ip protocol { tcp, udp } tproxy ip to 127.0.0.1:${toString tproxy-port} accept
        meta mark ${toString mark} meta nfproto ipv6 meta l4proto { tcp, udp } tproxy ip6 to [::1]:${toString tproxy-port} accept
        ip daddr @bogons_v4 udp dport != 53 return
        ip daddr @bogons_v4 tcp dport != 53 return
        ip6 daddr @bogons_v6 udp dport != 53 return
        ip6 daddr @bogons_v6 tcp dport != 53 return
        ip protocol { tcp, udp } meta mark set ${toString mark} tproxy ip to 127.0.0.1:${toString tproxy-port} accept
        meta nfproto ipv6 meta l4proto { tcp, udp } meta mark set ${toString mark} tproxy ip6 to [::1]:${toString tproxy-port} accept
      }
    '';
  };

  networking.firewall.extraInputRules = ''
    meta mark ${toString mark} accept
    meta mark != ${toString mark} ct state new ct mark set ${toString direct-mark}
  '';

  networking.localCommands = ''
    ip route replace local default dev lo table ${toString table} &&
      { ip rule del fwmark ${toString mark} lookup ${toString table} priority ${toString table} 2>/dev/null || true
        ip rule add fwmark ${toString mark} lookup ${toString table} priority ${toString table}; } || true
    ip -6 route replace local default dev lo table ${toString table} &&
      { ip -6 rule del fwmark ${toString mark} lookup ${toString table} priority ${toString table} 2>/dev/null || true
        ip -6 rule add fwmark ${toString mark} lookup ${toString table} priority ${toString table}; } || true
    ip route replace 10.11.0.0/16 dev lo metric 1024 2>/dev/null || true
    ip -6 route replace fd11::/16 dev lo metric 1024 2>/dev/null || true
  '';

  systemd.services.sing-box.serviceConfig = {
    AmbientCapabilities = [ "CAP_NET_ADMIN" "CAP_NET_RAW" ];
    CapabilityBoundingSet = [ "CAP_NET_ADMIN" "CAP_NET_RAW" ];
    Restart = "always";
    RestartSec = 3;
  };
  services.sing-box = {
    enable = true;
    settings = {
      inbounds = [
        {
          type = "tproxy";
          listen = "::";
          listen_port = tproxy-port;
        }
      ];
      outbounds = [
        {
          type = "socks";
          tag = "home";
          server = "127.0.0.1";
          server_port = home-port;
          version = "5";
          bind_interface = "lo";
        }
        { type = "direct"; tag = "direct"; }
      ];
      route = {
        auto_detect_interface = true;
        rules = [
          { action = "sniff"; }
          { domain = [ "sing-portal.ani.llc" ]; outbound = "direct"; }
        ];
        final = "home";
      };
    };
  };
}
