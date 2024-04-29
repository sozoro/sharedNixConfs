{
  description = "";
  inputs = {
    non-variable-noto-fonts.url = "github:sozoro/non-variable-noto-fonts.nix";
  };

  outputs = { config, pkgs, lib, non-variable-noto-fonts, ... }:
  let
    customIosevka = import ./iosevka.nix { inherit pkgs; };
    # DPI for 2560x1440 display
    dpi = 160;
  in
    { fonts = {
        packages = with pkgs; [
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
              "IBM Plex Mono"
              "Meslo LG S"
              "Noto Sans Mono"
            ];
            serif     = lib.mkOrder 75 [ "IBM Plex Serif" "Noto Sans" ];
            sansSerif = lib.mkOrder 75 [ "IBM Plex Sans" "Noto Sans" ];
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
    };
