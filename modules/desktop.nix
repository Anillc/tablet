{ pkgs, lib, ... }: {
  services = {
    libinput.enable = true;
    iptsd = {
      enable = true;
      config.Touchscreen = {
        DisableOnStylus = true;
        DisableOnPalm = true;
      };
    };
  };

  security.pam.services.hyprlock = { };
  security.pam.services.hypr-rdp = { };
  networking.firewall.allowedTCPPorts = [ 3389 ];
  environment.persistence."/persist".users.anillc.directories = [
    ".config/hypr-rdp"
  ];
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    source-han-sans
    font-awesome
  ] ++ lib.filter lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
