{ pkgs, ... }:
{ nixpkgs.config.packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in {
    mplayer = (oldpkgs.mplayer.override {
      jackaudioSupport = true;
      bluraySupport    = false;
    }).overrideAttrs (attrs: oldAttrs: {
      # For ffmpeg 1.5-unstable-2024-07-03
      # https://www.linuxquestions.org/questions/slackware-14/compile-latest-mplayer-svn-in-slackware-15-0-a-4175743148/
      # downgrade ffmpeg version
      buildInputs = (builtins.filter (x: ! (newpkgs.lib.hasPrefix "ffmpeg" x.name)) oldAttrs.buildInputs) ++ [ newpkgs.ffmpeg_6 ];
    });
  };

  environment.systemPackages = with pkgs; [ mplayer ];
}
