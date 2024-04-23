{ config, pkgs, lib, ... }:
let
  packagePath = ./japanese;
  packageName = lib.last (builtins.split "/" (toString packagePath));
  install     = "opt";
in
  { nixpkgs.config = {
      packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in{
        "myVimPlugins_${packageName}" = newpkgs.vimUtils.buildVimPlugin rec {
          pname        = packageName;
          name         = pname;
          src          = packagePath;
          dependencies = [];
        };
      };
    };

    programs.vim.plugins = {
      start = if install == "start" then [ pkgs."myVimPlugins_${packageName}" ] else [];
      opt   = if install == "opt"   then [ pkgs."myVimPlugins_${packageName}" ] else [];
    };
  }
