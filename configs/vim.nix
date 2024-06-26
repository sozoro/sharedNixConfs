{ config, pkgs, lib, ... }:
let
  cfg = config.programs.vim;

  vimCustomize = {
    name = "vim";
    vimrcConfig = {
      packages.myVimPackage = cfg.plugins;
      customRC              = builtins.readFile ./vimrc + cfg.extraConfig;
    };
  };
in
  { options = with lib; {
      programs.vim = {
        plugins = {
          start = mkOption {
            type        = with types; listOf package;
            default     = [];
            description = "vim start packages";
          };
          opt = mkOption {
            type        = with types; listOf package;
            default     = [];
            description = "vim opt packages";
          };
        };
        extraConfig = mkOption {
          type        = types.lines;
          default     = "";
          description = "extra vimrc configs";
        };
      };
    };

    config = lib.mkMerge [
      { environment = {
          variables.EDITOR = "vim";
          systemPackages   = with pkgs; with lib; [

            # vim with not Python 3 but Python 2 for agda-vim plugin
            # supporting both Python 2 and Python 3 causes a problem
            ((vimUtils.makeCustomizable
            (overrideDerivation (vim_configurable.override {
              # clipboard feature requires guiSupport
              # guiSupport       = "false";
              multibyteSupport = true;
              pythonSupport    = false;
            }) (old: {
              configureFlags =
                (filter (x: x != "--disable-pythoninterp") old.configureFlags)
                ++ [
                  "--enable-pythoninterp"
                  "--with-python-config-dir=${python2}/lib"
                ];
              buildInputs = old.buildInputs ++ [ python2 ];
            }))).customize vimCustomize)

            # for zip.vim
            pkgs.zip

          ];
        };

        nixpkgs.config.permittedInsecurePackages = [
          "python-2.7.18.6"
        ];
      }

      { programs.vim.plugins.start = with pkgs.vimPlugins; [
          agda-vim
          vim-mundo
        ];
      }

      # Python2 is marked as insecure because Python 2.7 has reached its end of life after 2020-01-01.
      {
        nixpkgs.config.permittedInsecurePackages = [
          "python-2.7.18.8"
        ];
      }
    ];
  }
