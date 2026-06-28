{ config, pkgs, lib, ... }:
{ xdg.portal = {
    enable = true;

    # for xmonad
    extraPortals = [
      pkgs.xdg-desktop-portal-xapp
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "xapp" "gtk" ];
      };
    };
  };
}
