{ config, pkgs, lib, ... }:
let
  customIosevka = import ./iosevka.nix { inherit pkgs; };
  # DPI for 2560x1440 display
  dpi = 160;
in
  { imports = [
      ./../packages/non-variable-noto-fonts.nix
    ];

    fonts = {
      fonts = with pkgs; [
        # noto-fonts
        # noto-fonts-cjk
        non-variable-noto-fonts.noto-fonts
        non-variable-noto-fonts.noto-fonts-cjk-sans
        non-variable-noto-fonts.noto-fonts-cjk-serif
        meslo-lg
        customIosevka
        mplus-outline-fonts.githubRelease
        ibm-plex
        # (import ./iosevkaNotoCJK.nix { inherit pkgs; })
      ];
      fontconfig = {
        defaultFonts = {
          monospace = [
            "Custom Iosevka"
            "Meslo LG S"
            "Noto Sans Mono"
          ];
          serif     = [ "Noto Sans" ];
          sansSerif = [ "Noto Sans" ];
        };
        allowBitmaps = false;
        antialias    = true;
        hinting      = {
          enable   = true;
          autohint = false;
        };
        subpixel = {
          lcdfilter = "default";
          rgba      = "rgb";
        };
        # penultimate.enable = false;
      };
    };
    services.xserver.displayManager.sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
         Xft.dpi: ${toString dpi}
      EOF
    '';
  }
