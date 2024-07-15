{ config, pkgs, lib, ... }:
{ programs.dconf.enable = true;
  # services.dbus.packages = [ pkgs.gnome3.dconf ];
  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];
  environment.systemPackages = with pkgs; [ gtk3 adwaita-icon-theme ];
}
