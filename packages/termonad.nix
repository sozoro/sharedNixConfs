{ config, pkgs, lib, ... }:
let
  packagePath     = ./termonad_hs;
  packageName     = "termonad";
  install         = true;
  compiler        = null;
  haskellPackages = (if   isNull compiler
                     then pkgs.haskellPackages
                     else pkgs.haskell.packages.${compiler}).override {
    overrides = self: super: {
    };
  };
in
  { nixpkgs.config = {
      packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in{
        "${packageName}" = newpkgs.callPackage packagePath {
          haskellPackages = haskellPackages;
        };
      };
    };
    environment.systemPackages = if install then [ pkgs."${packageName}" ] else [];
  }
