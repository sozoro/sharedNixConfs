{ config, pkgs, lib, ... }:
# https://github.com/lifepillar/vim-colortemplate
let
  baseName  = "lifepillar_vim-devel";
  vim-devel = pkgs.fetchFromGitHub {
    owner = "lifepillar";
    repo  = "vim-devel";
    rev   = "706d4b4a27831fcbfcec2b2c9d7648994ef6cc97";
    hash  = "sha256-RS3PuEM1W1XLPktLPy/AqROEksNLa6RSzbAdWAqUDUs=";
  };
  libDirs = lib.filterAttrs (name: value: value == "directory") (builtins.readDir "${vim-devel}/start");
  plugins = builtins.mapAttrs (name: _: pkgs.vimUtils.buildVimPlugin {
    inherit name;
    pname        = name;
    src          = "${vim-devel}/start/${name}";
    dependencies = [];
  }) libDirs;
in
  {
    nixpkgs.config.packageOverrides = oldpkgs: {
      "${baseName}" = plugins;
    };
    programs.vim.plugins.start = lib.mapAttrsToList (name: value: pkgs."${baseName}"."${name}") plugins;
  }
