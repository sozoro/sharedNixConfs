{ config, pkgs, lib, ... }:
{ imports = [ ./fcitx-homeSettings.nix ];

  i18n.inputMethod.fcitx5 = {
    addons = with pkgs; [ fcitx5-mozc ] ;

    homeSettings = {
      "profile" = ''
        [Groups/0]
        # Group Name
        Name="Group 1"
        # Layout
        Default Layout=jp
        # Default Input Method
        DefaultIM=mozc

        [Groups/0/Items/0]
        # Name
        Name=keyboard-jp
        # Layout
        Layout=

        [Groups/0/Items/1]
        # Name
        Name=mozc
        # Layout
        Layout=

        [GroupOrder]
        0="Group 1"
      '';
    };
  };
}
