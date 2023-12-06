{ config, pkgs, lib, ... }:
let
  cfg   = config.i18n.inputMethod.fcitx5.homeSettings;
  fcitx5 = config.i18n.inputMethod.package;

  fcitxConfDir = "$HOME/.config/fcitx5";

  writeConf = file: conf: ''
    mkdir -p $(dirname "${file}")
    echo "${conf}" > "${file}"
  '';

  setupCommand = "fcitx-homeSettings";
  fcitx-homeSettings = with lib; pkgs.writeShellScriptBin setupCommand (''
    confDir=${fcitxConfDir}
    if [ ! -d $confDir ]; then
      echo running fcitx to generate default settings
      ${fcitx5}/bin/fcitx5 -d
      sleep 0.5
    fi
    pushd $confDir
  ''
  +
  concatStrings (mapAttrsToList writeConf cfg)
  +
  ''
    popd
    ${fcitx5}/bin/fcitx5-remote -r
  '');
in with lib;
  { options = {
      i18n.inputMethod.fcitx5.homeSettings = with types; mkOption {
        type        = attrsOf lines;
        default     = {};
        example     = {
          "conf/xcb.conf" = ''
            Allow Overriding System XKB Settings=False
          '';
          "config" = ''
            [Hotkey/TriggerKeys]
            0=Control+space

            [Hotkey/ActivateKeys]
            0=Henkan
            1=Hiragana_Katakana

            [Hotkey/DeactivateKeys]
            0=Muhenkan
          '';
        };
        description = "setting files in ${fcitxConfDir}";
      };
    };

    config = mkMerge [
      (mkIf (config.i18n.inputMethod.enabled == "fcitx5") {
        environment.systemPackages = [ fcitx-homeSettings ];
        services.xserver.displayManager.sessionCommands = mkOrder 1000 ''
          ${fcitx-homeSettings}/bin/${setupCommand}
        '';
      })

      { i18n.inputMethod.fcitx5.homeSettings = {
          "conf/xcb.conf" = ''
            Allow Overriding System XKB Settings=False
          '';
        };
      }
    ];
  }
