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

    # Greek Core Alphabet Uppercase
    <Multi_key> <g> <A> :       "Α"    U0391    # GREEK CAPITAL LETTER ALPHA
    <Multi_key> <g> <B> :       "Β"    U0392    # GREEK CAPITAL LETTER BETA
    <Multi_key> <g> <G> :       "Γ"    U0393    # GREEK CAPITAL LETTER GAMMA
    <Multi_key> <g> <D> :       "Δ"    U0394    # GREEK CAPITAL LETTER DELTA
    <Multi_key> <g> <E> :       "Ε"    U0395    # GREEK CAPITAL LETTER EPSILON
    <Multi_key> <g> <Z> :       "Ζ"    U0396    # GREEK CAPITAL LETTER ZETA
    <Multi_key> <g> <H> :       "Η"    U0397    # GREEK CAPITAL LETTER ETA
    <Multi_key> <g> <Q> :       "Θ"    U0398    # GREEK CAPITAL LETTER THETA
    <Multi_key> <g> <I> :       "Ι"    U0399    # GREEK CAPITAL LETTER IOTA
    <Multi_key> <g> <K> :       "Κ"    U039A    # GREEK CAPITAL LETTER KAPPA
    <Multi_key> <g> <L> :       "Λ"    U039B    # GREEK CAPITAL LETTER LAMBDA
    <Multi_key> <g> <M> :       "Μ"    U039C    # GREEK CAPITAL LETTER MU
    <Multi_key> <g> <N> :       "Ν"    U039D    # GREEK CAPITAL LETTER NU
    <Multi_key> <g> <X> :       "Ξ"    U039E    # GREEK CAPITAL LETTER XI
    <Multi_key> <g> <O> :       "Ο"    U039F    # GREEK CAPITAL LETTER OMIKRON
    <Multi_key> <g> <P> :       "Π"    U03A0    # GREEK CAPITAL LETTER PI
    <Multi_key> <g> <R> :       "Ρ"    U03A1    # GREEK CAPITAL LETTER RHO
    <Multi_key> <g> <S> :       "Σ"    U03A3    # GREEK CAPITAL LETTER SIGMA
    <Multi_key> <g> <T> :       "Τ"    U03A4    # GREEK CAPITAL LETTER TAU
    <Multi_key> <g> <U> :       "Υ"    U03A5    # GREEK CAPITAL LETTER UPSILON
    <Multi_key> <g> <F> :       "Φ"    U03A6    # GREEK CAPITAL LETTER PHI
    <Multi_key> <g> <J> :       "Χ"    U03A7    # GREEK CAPITAL LETTER KHI
    <Multi_key> <g> <V> :       "Ψ"    U03A8    # GREEK CAPITAL LETTER PSI
    <Multi_key> <g> <W> :       "Ω"    U03A9    # GREEK CAPITAL LETTER OMEGA
    #
    # Greek Core Alphabet Lowercase
    <Multi_key> <g> <a> :       "α"    U03B1    # GREEK SMALL LETTER ALPHA
    <Multi_key> <g> <b> :       "β"    U03B2    # GREEK SMALL LETTER BETA
    <Multi_key> <g> <g> :       "γ"    U03B3    # GREEK SMALL LETTER GAMMA
    <Multi_key> <g> <d> :       "δ"    U03B4    # GREEK SMALL LETTER DELTA
    <Multi_key> <g> <e> :       "ε"    U03B5    # GREEK SMALL LETTER EPSILON
    <Multi_key> <g> <z> :       "ζ"    U03B6    # GREEK SMALL LETTER ZETA
    <Multi_key> <g> <h> :       "η"    U03B7    # GREEK SMALL LETTER ETA
    <Multi_key> <g> <q> :       "θ"    U03B8    # GREEK SMALL LETTER THETA
    <Multi_key> <g> <i> :       "ι"    U03B9    # GREEK SMALL LETTER IOTA
    <Multi_key> <g> <k> :       "κ"    U03BA    # GREEK SMALL LETTER KAPPA
    <Multi_key> <g> <l> :       "λ"    U03BB    # GREEK SMALL LETTER LAMBDA
    <Multi_key> <g> <m> :       "μ"    U03BC    # GREEK SMALL LETTER MU
    <Multi_key> <g> <n> :       "ν"    U03BD    # GREEK SMALL LETTER NU
    <Multi_key> <g> <x> :       "ξ"    U03BE    # GREEK SMALL LETTER XI
    <Multi_key> <g> <o> :       "ο"    U03BF    # GREEK SMALL LETTER OMIKRON
    <Multi_key> <g> <r> :       "ρ"    U03C1    # GREEK SMALL LETTER RHO
    <Multi_key> <g> <c> :       "ς"    U03C2    # GREEK SMALL LETTER FINAL SIGMA
    <Multi_key> <g> <s> :       "σ"    U03C3    # GREEK SMALL LETTER SIGMA
    <Multi_key> <g> <t> :       "τ"    U03C4    # GREEK SMALL LETTER TAU
    <Multi_key> <g> <u> :       "υ"    U03C5    # GREEK SMALL LETTER UPSILON
    <Multi_key> <g> <f> :       "φ"    U03C6    # GREEK SMALL LETTER PHI
    <Multi_key> <g> <j> :       "χ"    U03C7    # GREEK SMALL LETTER KHI
    <Multi_key> <g> <v> :       "ψ"    U03C8    # GREEK SMALL LETTER PSI
    <Multi_key> <g> <w> :       "ω"    U03C9    # GREEK SMALL LETTER OMEGA
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
      xkb.options = "terminate:ctrl_alt_bksp,ctrl:swapcaps,compose:ralt";

      # this priority should be bigger than fcitx-homeSettings's one
      displayManager.sessionCommands = lib.mkOrder 1100 ''
        ${setupkeys}/bin/setupkeys
      '';
    };
  }
