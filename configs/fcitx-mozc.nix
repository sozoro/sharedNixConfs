{ config, pkgs, lib, ... }:
{ imports = [ ./fcitx-homeSettings.nix ];

  i18n.inputMethod.fcitx5 = {
    addons = with pkgs; [ fcitx5-mozc ] ;

    homeSettings = {
      "profile" = {
        IMName        = "mozc";
        EnabledIMList = "fcitx-keyboard-jp:True,mozc:True";
      };
    };
  };
}
