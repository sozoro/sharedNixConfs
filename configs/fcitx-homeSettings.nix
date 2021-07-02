{ config, pkgs, lib, ... }:
let
  cfg   = config.i18n.inputMethod.fcitx.homeSettings;
  fcitx = config.i18n.inputMethod.package;

  sedSetting = file: item: value: ''
    ${pkgs.gnused}/bin/sed -i -e "s/^#\?[ ]*${item}[ ]*=.*/${item}=${value}/" ${file}
  '';
  setupCommand = "fcitx-homeSettings";
  fcitx-homeSettings = with lib; pkgs.writeShellScriptBin setupCommand (''
    confDir=$HOME/.config/fcitx
    if [ ! -d $confDir ]; then
      echo running fcitx to generate default settings
      ${fcitx}/bin/fcitx -d
      sleep 0.5
    fi
    pushd $confDir
  ''
  +
  concatStrings (flatten (mapAttrsToList (file: mapAttrsToList (sedSetting file)) cfg))
  +
  ''
    popd
    ${fcitx}/bin/fcitx-remote -r
  '');
in with lib;
  { options = {
      i18n.inputMethod.fcitx.homeSettings = with types; mkOption {
        type        = attrsOf (attrsOf str);
        default     = {};
        example     = {
          "conf/fcitx-xkb.config" = {
            OverrideSystemXKBSettings = "False";
          };
          "config" = {
            SwitchKey = "Disabled";
          };
        };
        description = "setting files in $HOME/.config/fcitx";
      };
    };

    config = mkMerge [
      (mkIf (config.i18n.inputMethod.enabled == "fcitx") {
        environment.systemPackages = [ fcitx-homeSettings ];
        services.xserver.displayManager.sessionCommands = mkOrder 1000 ''
          ${fcitx-homeSettings}/bin/${setupCommand}
        '';
      })

      { i18n.inputMethod.fcitx.homeSettings = {
          "conf/fcitx-xkb.config" = {
            OverrideSystemXKBSettings = "False";
          };
        };
      }
    ];
  }
