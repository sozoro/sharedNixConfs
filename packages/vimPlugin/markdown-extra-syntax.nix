{ config, pkgs, lib, ... }:
let
  packagePath = ./markdown-extra-syntax;
  packageName = lib.last (builtins.split "/" (toString packagePath));
  install     = true;
in
  { nixpkgs.config = {
      packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in{
        "myVimPlugins_${packageName}" = newpkgs.vimUtils.buildVimPluginFrom2Nix rec {
          pname        = packageName;
          name         = pname;
          src          = packagePath;
          dependencies = [];
        };
      };
    };

    programs.vim = {
      plugins.start = if install then [ pkgs."myVimPlugins_${packageName}" ] else [];
      extraConfig   = ''
        augroup markdown_extra_syntax
            au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown_extra
        augroup END
      '';
    };
  }
