{ config, pkgs, lib, ... }:
{ config = {
    programs.adb.enable = true;
    # users.users.<your-user>.extraGroups = [ "adbusers" ];
  };
}
