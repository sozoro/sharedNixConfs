{ config, pkgs, lib, ... }:
{ programs.dconf.enable = true;
  # services.dbus.packages = [ pkgs.gnome.dconf ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  environment.systemPackages = with pkgs; [ gtk3 adwaita-icon-theme ];
}
