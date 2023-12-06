{ config, pkgs, lib, ... }:
let
  fcitx5 = config.i18n.inputMethod.package;
in
  { imports                    = [ ./xserver.nix ];
    environment.systemPackages = [ pkgs.fcitx5-configtool ];
    i18n.inputMethod           = {
      enabled       = "fcitx5";
      # fcitx.engines = with pkgs.fcitx-engines; [ mozc ] ;
      fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ] ;
    };
    services.xserver.displayManager.sessionCommands = lib.mkOrder 900 ''
      ${fcitx5}/bin/fcitx5 -d --enable mozc
    '';
  }
