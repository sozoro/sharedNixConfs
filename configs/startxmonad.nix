{ config, pkgs, lib, ... }:
with pkgs; with lib; with lists;
let
  noneXmonad    = "none+xmonad";
  sessions      = config.services.xserver.displayManager.sessionPackages;
  xmonads       = filter (x: hasPrefix noneXmonad x.name) sessions;
  xmonad        = assert assertMsg (xmonads != []) "Xmonad is not enabled"; head xmonads;
  xmonadStarter = "${xmonad}/share/xsessions/${noneXmonad}.desktop";
  startxmonad   = writeShellScriptBin "startxmonad" ''
    ${xorg.xinit}/bin/startx "${config.services.xserver.displayManager.sessionData.wrapper}" "`${pkgs.gnused}/bin/sed -n -r "s/^Exec=//p" ${xmonadStarter}`"
  '';
in
  { imports     = [ ./xmonad.nix ../../configs/xserver.nix ];
    environment = {
      systemPackages   = [ xorg.xinit startxmonad ];
      shellAliases.sxm = "startxmonad";
      shellAliases.sxs = "echo use \"sxm\" instead of \"sxs\"";
    };
  }
