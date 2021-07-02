{ config, pkgs, lib, ... }:
{ imports = [ ./fcitx-homeSettings.nix ];

  i18n.inputMethod.fcitx.homeSettings = {
    "config" = {
      TriggerKey    = "";
      SwitchKey     = "Disabled";
      ActivateKey   = "HENKANMODE HIRAGANAKATAKANA";
      InactivateKey = "MUHENKAN";
    };
  };
}
