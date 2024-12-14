{ pkgs, ... }:
let
  # for mplayer 1.5-unstable-2024-07-03
  patch = fetchurl {
    url = "https://gitlab.archlinux.org/archlinux/packaging/packages/mplayer/-/blob/main/ffmpeg-7.patch";
    hash = "0l80dr3c0hqpz4yadawh1k5fnr7hka2dccain1awpimxbrcjb32x";
  };
in
{ nixpkgs.config.packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in {
    mplayer = (oldpkgs.mplayer.override {
      jackaudioSupport = true;
      bluraySupport    = false;
    }).overrideAttrs (attrs: oldAttrs: {
      patches = (oldAttrs.patches or []) ++ [ patch ];
    });
  };

  environment.systemPackages = with pkgs; [ mplayer ];
}
