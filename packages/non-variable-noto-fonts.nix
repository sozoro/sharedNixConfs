# 2022/07/21
# noto-fonts package on main branch of nixpkgs only exports variable version
# while some application (etc. LuaTeX-ja) doesn't work well with variable font

let
  non-variable = import ./non-variable-noto-fonts/default.nix;
in
  { config, pkgs, lib, ... }:
  { nixpkgs.config.packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in {
      non-variable-noto-fonts = newpkgs.callPackage non-variable {};
    };
  }
