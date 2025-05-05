{ pkgs, ... }:
let
  # for mplayer 1.5-unstable-2024-12-21
  # https://www.linuxquestions.org/questions/slackware-14/compile-latest-mplayer-svn-in-slackware-15-0-a-4175743148/
  patch20240703 = pkgs.fetchpatch {
    name = "ffmpeg-7.patch";
    url = "https://gitlab.archlinux.org/archlinux/packaging/packages/mplayer/-/raw/main/ffmpeg-7.patch";
    hash = "sha256-s0242s0V4yln6praa6Q/tpxqesDNyjur2NjGqefDyxk=";
    stripLen = 0;
    extraPrefix = "";
  };
in
{ nixpkgs.config.packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in {
    mplayer = (oldpkgs.mplayer.override {
      jackaudioSupport = true;
      bluraySupport    = false;
    }).overrideAttrs (attrs: oldAttrs: {
      #NIX_DEBUG=7;
      patches = (oldAttrs.patches or []) ++ [
        patch20240703
      ];
    });
  };

  environment.systemPackages = with pkgs; [ mplayer ];
}
