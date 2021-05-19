{ config, pkgs, lib, ... }:
{ environment = {
    systemPackages = [ pkgs.git ];
    variables.GIT_ASKPASS = "";
  };
}
