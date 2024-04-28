{ config, pkgs, lib, ... }:
let
  xresources = with config.fonts.fontconfig; pkgs.writeText "Xresources" ''
  '';
in
  { # imports = [ ./xmonad.nix ];

    environment.systemPackages = [ pkgs.picom ];
    services.picom = {
      enable        = true;
      shadow        = true;
      shadowExclude = [
        # https://wiki.archlinux.org/index.php/Picom#Firefox
        "class_g = 'firefox' && argb"
        "class_g = 'Firefox' && argb"
      ];
    };
    systemd.user.services.picom.wantedBy = lib.mkForce [];

    services = {
      xserver = {
        autoRepeatDelay     = 220;
        autoRepeatInterval  = 30;
        exportConfiguration = true;
        serverFlagsSection  = ''
          Option "BlankTime" "0"
          Option "StandbyTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
        '';
        displayManager.sessionCommands = ''
          export TERM=xterm-256color
          ${pkgs.xorg.xrdb}/bin/xrdb -merge ${xresources}
          ${pkgs.xorg.xset}/bin/xset r rate 220 30
          ${config.systemd.user.services.picom.serviceConfig.ExecStart} -b
        '';
      };

      libinput = {
        enable = true;
      };
    };
  }
