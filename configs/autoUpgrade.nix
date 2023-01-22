{ config, pkgs, lib, ... }:

# nixos-upgrade.timer
# nixos-upgrade.service

{ system.autoUpgrade = {
    enable      = true;
    operation   = "boot";
    dates       = "Tue,Thu *-*-* 04:00:00";
    allowReboot = false;
  };
}
