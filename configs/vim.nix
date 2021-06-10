{ config, pkgs, lib, ... }:
let
  vimCustomize = start: {
    name = "vim";
    vimrcConfig = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = start;
      };
      customRC = builtins.readFile ./vimrc;
    };
  };
in
  { options = with lib; {
      programs.vim.plugins.start = mkOption {
        type        = with types; listOf package;
        default     = [];
        description = "vim start packages";
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
              guiSupport       = "false";
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
            }))).customize (vimCustomize config.programs.vim.plugins.start))

            # for zip.vim
            pkgs.zip

          ];
        };
      }

      { programs.vim.plugins.start = with pkgs.vimPlugins; [
          agda-vim
          vim-mundo
        ];
      }
    ];
  }
