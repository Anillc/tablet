{ pkgs, ... }:

{
  networking.hostName = "duet";
  networking.networkmanager.enable = true;
  environment.persistence."/persist".directories = [ "/etc/NetworkManager" ];

  networking.nftables.enable = true;
  networking.nftables.flushRuleset = false;
  networking.firewall.checkReversePath = false;

  boot.kernelModules = [ "br_netfilter" ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv4.conf.all.rp_filter" = 0;
    "net.ipv4.conf.default.rp_filter" = 0;
    "net.ipv6.conf.all.forwarding" = 1;
    "net.bridge.bridge-nf-call-iptables" = 0;
    "net.bridge.bridge-nf-call-ip6tables" = 0;
  };

  services.tailscale.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
