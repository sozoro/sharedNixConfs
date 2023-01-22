{ config, pkgs, lib, ... }:
with pkgs;
let
  termiteConfigFile = writeText "config" ''
    [options]
    allow_bold       = false
    audible_bell     = false
    clickable_url    = false
    dynamic_title    = true
    font             = Iosevka Custom 12
    mouse_autohide   = true
    # Length of the scrollback buffer, 0 disabled the scrollback buffer
    # and setting it to a negative value means "infinite scrollback"
    scrollback_lines = 10000
    # "system", "on" or "off"
    cursor_blink     = off
    # "block", "underline" or "ibeam"
    cursor_shape = block
    # "off", "left" or "right"
    scrollbar = off

    [colors]
    # If both of these are unset, cursor falls back to the foreground color,
    # and cursor_foreground falls back to the background color.
    # cursor = #F02BA2
    # cursor_foreground = #000000
    foreground = #e3eafc
    # (requires a compositor)
    background = rgba(17, 17, 17, 0.7)
    # If unset, will reverse foreground and background
    #highlight = #2f2f2f
    # Colors from color0 to color254 can be set
    color0  = #263238
    color1  = #FF5252
    color2  = #68F3C9
    color3  = #FEE94E
    color4  = #2BCFF0
    color5  = #F02BA2
    color6  = #68B6F3
    color7  = #ECEFF1
    color8  = #525252
    color9  = #FF7281
    color10 = #68F3C9
    color11 = #FEE94E
    color12 = #2BCFF0
    color13 = #F02BA2
    color14 = #68B6F3
    color15 = #FFFFFF

    [hints]
  '';

  termiteCommand = "${termite}/bin/termite -c $TermiteConfigFile";

  termite-transparency = writeScriptBin "termite-transparency" ''
    set -e
    if [[ $@ =~ [\.0-9] ]]; then
      val=$@
      ${gnused}/bin/sed -i "/^background = /s/[\.0-9]*)$/$val)/" $TermiteConfigFile

      p=$$
      while [[ `cat /proc/$p/cmdline | xargs -0 echo` != "${termiteCommand}"* ]]; do
        echo $p, `cat /proc/$p/comm`
        if [ $p = "1" ]; then
          echo there is no valid termite parent
          exit 1
        fi
        p=`cat /proc/$p/stat | awk '{print $4}'`
      done

      echo send USR1 signal to $p
      kill -USR1 $p
    else
      ${coreutils}/bin/echo "Usage:"
      ${coreutils}/bin/echo "  termite-transparency [transparency : 0.0 ~ 1.0]"
    fi
  '';

  termite-wrapped = writeShellScriptBin "termite-wrapped" ''
    hash=`${coreutils}/bin/date +%Y%m%d%H%M%S%N | ${coreutils}/bin/sha1sum | ${gnused}/bin/sed "s/ *-//"`
    export TermiteConfigFile=/tmp/termite-config-$UID/$hash
    export PATH=$PATH:${termite-transparency}/bin
    ${coreutils}/bin/install -m 446 -D ${termiteConfigFile} $TermiteConfigFile
    ${termiteCommand} $@
    ${coreutils}/bin/rm $TermiteConfigFile
  '';
in
  { imports     = [ ./xsettingsd.nix ];
    # fonts.fonts = [ monoid ];
    environment.systemPackages = [
      termite
      termite-wrapped
    ];
  }
