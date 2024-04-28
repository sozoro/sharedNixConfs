{ pkgs, ... }:
{ environment = {
    systemPackages                 = [ pkgs.qogir-theme ];
    variables.QT_QPA_PLATFORMTHEME = "gtk3";
  };
}
