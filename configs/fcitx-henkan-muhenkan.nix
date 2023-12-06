{ config, pkgs, lib, ... }:
{ imports = [ ./fcitx-homeSettings.nix ];

  i18n.inputMethod.fcitx5.homeSettings = {
    "config" = ''
      [Hotkey/TriggerKeys]
      0=Control+space

      [Hotkey/ActivateKeys]
      0=Henkan
      1=Hiragana_Katakana

      [Hotkey/DeactivateKeys]
      0=Muhenkan
    '';
  };
}
