{ xmonad_hs, ... }: { config, pkgs, lib, ... }:
{ environment.systemPackages = with pkgs; [ dmenu xorg.xprop ];
  services = {
    displayManager = {
      defaultSession  = "none+xmonad";
    };

    xserver = {
      enable         = true;
      autorun        = false;
      displayManager = {
        sessionCommands = ''
          ${pkgs.coreutils}/bin/rm ~/.xmonad/xmonad.state
        '';
      };
      windowManager.xmonad = {
        enable                 = true;
        enableContribAndExtras = true;
        config                 = xmonad_hs.xmonad_hs;
      };
    };
  };
}
