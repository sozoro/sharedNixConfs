{ config, pkgs, lib, ... }:
let
  packagePath = ./pandoc-markdown-table-formatter;
  packageName = lib.last (builtins.split "/" (toString packagePath));
  install     = true;
in
  { nixpkgs.config = {
      packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in{
        myVimPlugins."${packageName}" = newpkgs.vimUtils.buildVimPluginFrom2Nix {
          name         = packageName;
          src          = packagePath;
          dependencies = [];
        };
      };
    };

    programs.vim.plugins.start = [ pkgs.myVimPlugins."${packageName}" ];
  }
