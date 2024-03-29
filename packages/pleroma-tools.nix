{ pkgs, lib, ... }:
let
  packagePath = ./pleroma-tools;
  packageName = lib.last (builtins.split "/" (toString packagePath));
  install     = true;
in
  { nixpkgs.config = {
      packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in{
        "${packageName}" = newpkgs.callPackage packagePath {
        };
      };
    };
    environment.systemPackages = if install then [ pkgs."${packageName}" ] else [];
  }
