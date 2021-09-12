{ config, pkgs, lib, ... }:
let
  packagePath = ./vim-ghci;
  packageName = lib.last (builtins.split "/" (toString packagePath));
  install     = true;
in
  { nixpkgs.config = {
      packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in{
        "myVimPlugins_${packageName}" = newpkgs.vimUtils.buildVimPluginFrom2Nix {
          name         = packageName;
          src          = packagePath;
          dependencies = [];
        };
      };
    };

    programs.vim.plugins.start = if install then [ pkgs."myVimPlugins_${packageName}" ] else [];
  }
