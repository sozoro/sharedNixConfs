{ pkgs, ... }:
# Ref: https://github.com/nix-community/home-manager/issues/200
let
  xcursorTheme   = "capitaine-cursors";
  xcursorPackage = pkgs.capitaine-cursors;
  # xcursorFile    = "X_cursor";
  xcursorFile    = "default";
  xcursorSize    = 48;
in
{ environment = {
    profileRelativeEnvVars.XCURSOR_PATH = [ "/share/icons" ];

    systemPackages = [ xcursorPackage ];

    etc."gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-cursor-theme-name=${xcursorTheme}
        gtk-cursor-theme-size=${toString xcursorSize}
      '';
      mode = "444";
    };

    etc."gtk-2.0/gtkrc" = {
      text = ''
       gtk-cursor-theme-name="${xcursorTheme}"
       gtk-cursor-theme-size=${toString xcursorSize}
      '';
      mode = "444";
    };

  };

  services.xserver.displayManager.sessionCommands =
  let
    xresources = pkgs.writeText "Xresources" ''
      Xcursor.theme: ${xcursorTheme}
      Xcursor.size: ${toString xcursorSize}
    '';
  in
    ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge ${xresources}
      ${pkgs.xorg.xsetroot} -xcf ${xcursorPackage}/share/icons/${xcursorTheme}/cursors/X_cursor ${toString xcursorSize}
    '';
}
