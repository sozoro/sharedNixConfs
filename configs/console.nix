{ config, pkgs, lib, ... }:
{ i18n.defaultLocale      = "en_US.UTF-8";
  services.xserver.layout = "jp";
  console                 = {
    useXkbConfig = true;
    font         = "latarcyrheb-sun32";
    earlySetup   = true;
  };
}
