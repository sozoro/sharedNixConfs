{ config, pkgs, lib, ... }:
with pkgs; with lib; with lists;
let
  #TODO:
  wms           = config.services.xserver.windowManager.session;
  wmStarters    = [ "[WindowManagers]" ] ++ map (wm: writeShellScript "${wm.name}-starter" wm.start) wms;
  wmStarterList = writeText "wmStarterList" (strings.concatStringsSep "\n" wmStarters);
  startxsession = writeShellScriptBin "startxsession" ''
    wmStarter=`${coreutils}/bin/cat ${wmStarterList} | ${fzf}/bin/fzf --layout=reverse --header-lines=1 --height=10%`
    if [ -z $wmStarter ]; then
      echo No WindowManager is selected.
      exit 1
    fi
    ${xorg.xinit}/bin/startx ${config.services.xserver.displayManager.sessionData.wrapper} $wmStarter
  '';
in
  { imports     = [ ./xserver.nix ];
    environment = {
      systemPackages   = [ xorg.xinit startxsession ];
    };
    services.xserver.displayManager.startx.enable = true;
  }
