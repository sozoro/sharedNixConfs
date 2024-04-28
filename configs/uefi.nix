{ ... }:
{ boot.loader = {
    timeout                  = 1;
    efi.canTouchEfiVariables = true;
    systemd-boot.enable      = true;
  };
}
