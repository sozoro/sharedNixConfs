{ config, pkgs, lib, ... }:
{ i18n.defaultLocale      = "en_US.UTF-8";
  services.xserver.xkb.layout = "jp";
  console                 = {
    useXkbConfig = true;
    # font         = "latarcyrheb-sun32";
    earlySetup   = true;
  };

  boot.initrd.kernelModules = [ "i915" ];
}
