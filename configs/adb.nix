{ config, pkgs, lib, ... }:
{ config = {
    programs.adb.enable = true;
    # users.users.<your-user>.extraGroups = [ "adbusers" ];

    # 'android-udev-rules' has been removed due to being superseded by built-in systemd uaccess rules.
    #services.udev.packages = [
    #  pkgs.android-udev-rules
    #];
  };
}
