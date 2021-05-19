{ config, pkgs, lib, ... }:
{ environment.systemPackages = with pkgs; [ dmenu xorg.xprop ];
  services.xserver = {
    enable         = true;
    autorun        = false;
    displayManager = {
      defaultSession  = "none+xmonad";
      sessionCommands = ''
        ${pkgs.coreutils}/bin/rm ~/.xmonad/xmonad.state
      '';
    };
    windowManager.xmonad = {
      enable                 = true;
      enableContribAndExtras = true;
      config                 = ./xmonad_hs/xmonad.hs;
    };
  };
}
