{ pkgs, ... }:
let
  # for mplayer 1.5-unstable-2024-07-03
  patch20240703 = fetchurl {
    url = "https://gitlab.archlinux.org/archlinux/packaging/packages/mplayer/-/blob/main/ffmpeg-7.patch";
    hash = "0l80dr3c0hqpz4yadawh1k5fnr7hka2dccain1awpimxbrcjb32x";
  };
  # for mplayer 1.5-unstable-2024-12-21
  patch20241125 = fetchurl {
    url = "https://ftp.openbsd.dk/mirrors/gentoo-portage/media-video/mplayer/files/mplayer-1.5_p20241125-c99.patch";
    hash = "0a6vw96i7m8siiy0b5bhxbxw44rzcr0d4yccnhirmi0izqnjzg4d";
  };
in
{ nixpkgs.config.packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in {
    mplayer = (oldpkgs.mplayer.override {
      jackaudioSupport = true;
      bluraySupport    = false;
    }).overrideAttrs (attrs: oldAttrs: {
      patches = (oldAttrs.patches or []) ++ [ patch20241125 ];
      # For ffmpeg 1.5-unstable-2024-07-03
      # https://www.linuxquestions.org/questions/slackware-14/compile-latest-mplayer-svn-in-slackware-15-0-a-4175743148/
      # downgrade ffmpeg version
      # buildInputs = (builtins.filter (x: ! (newpkgs.lib.hasPrefix "ffmpeg" x.name)) oldAttrs.buildInputs) ++ [ newpkgs.ffmpeg_6 ];
    });
  };

  environment.systemPackages = with pkgs; [ mplayer ];
}
