{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  environment.persistence."/persist".directories = [ "/etc/ssh" ];
}
