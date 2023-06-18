{ config, pkgs, lib, ... }:
let
  packageName = "zoom-us-wrapped";
in
  { imports = [ ./gnome.nix ];
    nixpkgs.config = {
      packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in{
        "${packageName}" = oldpkgs.zoom-us.overrideAttrs (oldAttrs: {
          nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ newpkgs.wrapGAppsHook ];
        });
      };
    };
  }
