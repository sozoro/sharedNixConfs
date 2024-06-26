{ config, pkgs, lib, ... }:
with pkgs; with lib; with lists;
let
  noneXmonad    = "none+xmonad";
  sessions      = config.services.displayManager.sessionPackages;
  xmonads       = filter (x: strings.hasPrefix noneXmonad x.name) sessions;
  xmonad        = assert assertMsg (xmonads != []) "Xmonad is not enabled"; head xmonads;
  xmonadStarter = "${xmonad}/share/xsessions/${noneXmonad}.desktop";
  startxmonad   = writeShellScriptBin "startxmonad" ''
    ${xorg.xinit}/bin/startx "${config.services.displayManager.sessionData.wrapper}" "`${pkgs.gnused}/bin/sed -n -r "s/^Exec=//p" ${xmonadStarter}`"
  '';
in
  { imports     = [ ./xserver.nix ./logind.nix ];
    environment = {
      systemPackages   = [ xorg.xinit startxmonad ];
      shellAliases.sxm = "startxmonad";
      shellAliases.sxs = "echo use \"sxm\" instead of \"sxs\"";
    };
    services.xserver.displayManager.startx.enable = true;
  }
