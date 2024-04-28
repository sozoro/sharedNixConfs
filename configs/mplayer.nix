{ pkgs, ... }:
{ nixpkgs.config.packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in {
    mplayer = oldpkgs.mplayer.override {
      jackaudioSupport = true;
      bluraySupport    = false;
    };
  };

  environment.systemPackages = with pkgs; [ mplayer ];
}
