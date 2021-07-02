{ config, pkgs, lib, ... }:
{ imports                    = [ ./xserver.nix ];
  environment.systemPackages = [ pkgs.fcitx-configtool ];
  i18n.inputMethod           = {
    enabled       = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ mozc ] ;
  };
}
