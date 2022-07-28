{ config, pkgs, lib, ... }:
let
  boolTo01       = b: if b then "1" else "0";
  xsettingsdConf = with config.fonts.fontconfig; pkgs.writeText "xsettingsd.conf" ''
    Xft/RGBA "${subpixel.rgba}"
    Xft/Antialias ${boolTo01 antialias}
    Xft/Hinting ${boolTo01 hinting.enable}
    Xft/HintStyle "hintslight"
    Net/IconThemeName "Paper"
    # Net/ThemeName "Qogir-light"
    Gtk/ButtonImages 1
    Gtk/MenuImages 1
  '';
in
  { imports                          = [ ./xserver.nix
                                         ./fonts.nix
                                       ];
    environment.systemPackages       = [ pkgs.xsettingsd ];
    systemd.user.services.xsettingsd = {
      description = "X settings daemon";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.xsettingsd}/bin/xsettingsd -c ${xsettingsdConf}";
        ExecStop = "${pkgs.procps}/bin/pkill xsettingsd";
      };
    };
  }
