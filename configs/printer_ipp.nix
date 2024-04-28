# https://nixos.wiki/wiki/Printing
{ config, pkgs, lib, ... }:
{ services.printing = {
    enable         = true;
    # extraFilesConf = ''
    #   SetEnv PATH /var/lib/cups/path/lib/cups/filter:/var/lib/cups/path/bin:/etc/share
    # '';
  };
  services.avahi.enable  = true;
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  environment.systemPackages = with pkgs; [ ghostscript ];
}
