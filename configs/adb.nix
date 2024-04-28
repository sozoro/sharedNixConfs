{ config, pkgs, lib, ... }:
{ config = {
    programs.adb.enable = true;
    # users.users.<your-user>.extraGroups = [ "adbusers" ];

    services.udev.packages = [
      pkgs.android-udev-rules
    ];
  };
}
