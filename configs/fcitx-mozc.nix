{ config, pkgs, lib, ... }:
{ imports = [ ./fcitx-homeSettings.nix ];

  i18n.inputMethod.fcitx = {
    engines = with pkgs.fcitx-engines; [ mozc ] ;

    homeSettings = {
      "profile" = {
        IMName        = "mozc";
        EnabledIMList = "fcitx-keyboard-jp:True,mozc:True";
      };
    };
  };
}
