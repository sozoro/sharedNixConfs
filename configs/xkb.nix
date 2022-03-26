{ config, pkgs, lib, ... }:
let
  swapKeysFile   = "swapKeys";
  caps-lctl-swap = "caps_lctl_swap";
  swapKeys       = pkgs.writeTextDir "symbols/${swapKeysFile}" ''
    partial modifier_keys
    xkb_symbols "${caps-lctl-swap}" {
      replace key <CAPS> { [ Control_L ] };
      replace key <LCTL> { [ Super_L ]   };
    };
  '';

  composeFile   = "compose";
  composeSymbol = "compose";
  compose       = pkgs.writeTextDir "symbols/${composeFile}" ''
    partial modifier_keys
    xkb_symbols "${composeSymbol}" {
      key <RALT> { [ Multi_key] };
    };
  '';

  # Generated from "${pkgs.xorg.setxkbmap}/bin/setxkbmap -print"
  mykbd = pkgs.writeText "mykbd" ''
    xkb_keymap {
            xkb_keycodes  { include "evdev+aliases(qwerty)" };
            xkb_types     { include "complete"              };
            xkb_compat    { include "complete+japan"        };
            xkb_geometry  { include "pc(pc104)"             };
            xkb_symbols   { include "pc+jp+inet(evdev)+terminate(ctrl_alt_bksp)+${swapKeysFile}(${caps-lctl-swap})+${composeFile}(${composeSymbol})" };
    };
  '';

  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp -I${swapKeys} -I${compose} ${mykbd} $out
  '';

  setupkeys = pkgs.writeShellScriptBin "setupkeys" ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY
  '';

  xcompose = pkgs.writeText "XCompose" ''
    include "%L"

    <Multi_key> <A> <A>                           : "∀"
    <Multi_key> <E> <E>                           : "∃"
    <Multi_key> <slash> <E> <E>                   : "∄"
    <Multi_key> <v> <v>                           : "∨"
    <Multi_key> <asciicircum> <asciicircum>       : "∧"
    <Multi_key> <backslash> <slash>               : "∨"
    <Multi_key> <slash> <backslash>               : "∧"
    <Multi_key> <equal> <equal>                   : "≡"
    <Multi_key> <slash> <equal> <equal>           : "≢"
    <Multi_key> <slash> <asciitilde> <asciitilde> : "≉"
    <Multi_key> <less> <asciitilde>               : "≲"
    <Multi_key> <greater> <asciitilde>            : "≳"
    <Multi_key> <slash> <less> <asciitilde>       : "≴"
    <Multi_key> <slash> <greater> <asciitilde>    : "≵"
    <Multi_key> <slash> <less> <equal>            : "≰"
    <Multi_key> <slash> <greater> <equal>         : "≱"
    <Multi_key> <equal> <less>                    : "⇐"
    <Multi_key> <equal> <asciicircum>             : "⇑"
    <Multi_key> <equal> <v>                       : "⇓"
    # <Multi_key> <less> <equal> <greater>          : "⇔"
    <Multi_key> <equal> <colon>                   : "≒"
    <Multi_key> <colon> <equal>                   : "≒"
    <Multi_key> <minus> <colon>                   : "÷"
    <Multi_key> <colon> <minus>                   : "÷"
    <Multi_key> <T> <T>                           : "⊤"
    <Multi_key> <underscore> <bar>                : "⊤"
    <Multi_key> <bar> <underscore>                : "⊥"
    <Multi_key> <bar> <minus>                     : "⊢"
    <Multi_key> <slash> <bar> <minus>             : "⊬"
    <Multi_key> <minus> <bar>                     : "⊣"
    <Multi_key> <bar> <equal>                     : "⊨"
    <Multi_key> <slash> <bar> <equal>             : "⊭"
    <Multi_key> <bar> <bar>                       : "∥"
    <Multi_key> <bar> <o>                         : "⊸"
    <Multi_key> <o> <C>                           : "℃"
    <Multi_key> <o> <F>                           : "℉"
    <Multi_key> <s> <period>                      : "ṣ"
    <Multi_key> <S> <period>                      : "Ṣ"
    <Multi_key> <r> <period>                      : "ṛ"
    <Multi_key> <R> <period>                      : "Ṛ"
    <Multi_key> <h> <period>                      : "ḥ"
    <Multi_key> <H> <period>                      : "Ḥ"
    <Multi_key> <d> <period>                      : "ḍ"
    <Multi_key> <D> <period>                      : "Ḍ"
    <Multi_key> <t> <period>                      : "ṭ"
    <Multi_key> <T> <period>                      : "Ṭ"
    <Multi_key> <z> <period>                      : "ẓ"
    <Multi_key> <Z> <period>                      : "Ẓ"
  '';
  # 「"」 + 「,」 = „
in
  { imports     = [ ./xserver.nix ./fcitx-homeSettings.nix ];
    environment = {
      systemPackages = [ setupkeys ];
      variables      = {
        XCOMPOSEFILE = "${xcompose}";
      };
    };
    services.xserver = {
      xkbOptions = "terminate:ctrl_alt_bksp,ctrl:swapcaps,compose:ralt";

      # this priority should be bigger than fcitx-homeSettings's one
      displayManager.sessionCommands = lib.mkOrder 1100 ''
        ${setupkeys}/bin/setupkeys
      '';
    };
  }
