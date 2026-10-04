{ pkgs, ... }:

{
  networking.hostName = "duet";
  networking.networkmanager.enable = true;
  environment.persistence."/persist".directories = [ "/etc/NetworkManager" ];

  services.tailscale.enable = true;

  programs.clash-verge = {
    enable = true;
    serviceMode = true;
    tunMode = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
