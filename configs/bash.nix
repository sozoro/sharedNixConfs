{ config, pkgs, lib, ... }:
{
  programs.bash = {
    enable = true;

    completion = {
      enable  = true;
      package = pkgs.bash-completion;
    };

    interactiveShellInit = ''
      export HISTSIZE=10000
      export SAVEHIST=100000
      bind '"\C-p": history-search-backward'
      bind '"\C-n": history-search-forward'
      bind 'set completion-ignore-case on'
    '';

    promptInit = ''
      __upDir__() {
        local upDirs upDir
        upDirs=$(dirname "$PWD")
        upDir=$(basename "$upDirs")
        [ "$upDir" != "/" ] && echo "$upDir"
      }

      __shellName__() {
        [ -n "$name" ] && echo " --''${name}--"
      }

      __gitBranch__() {
        local branch
        branch=$(git branch --show-current 2>/dev/null)
        [ -n "$branch" ] && echo " @$branch"
      }

      __firstRightPrompt__() {
          local rightPrompt
          rightPrompt=$(__gitBranch__)
          [ -n "$rightPrompt" ] || return
          tput -S <<< "
            civis
            sc
            cuf $((COLUMNS - ''${#rightPrompt}))
            setaf $__promptMainColor__
          "
          echo "$rightPrompt"
          tput -S <<< '
            rc
            cnorm
          '
      }

      __setExitStatus__() {
        __exitStatus__=$?
      }

      __setupFirstLeftPrompt__() {
        tput setaf $__promptDarkColor__
        if [ "''${__exitStatus__:-0}" -eq 0 ]
        then
          echo -n '+'
        else
          echo -n '-'
        fi
      }

      if !((UID)) && [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
        # NixOS default prompt for root user
        PROMPT_COLOR="1;31m"
        ((UID)) && PROMPT_COLOR="1;32m"
        if [ -n "$INSIDE_EMACS" ]; then
          # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
          PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
        else
          PS1="\n\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
        fi
        if test "$TERM" = "xterm"; then
          PS1="\[\033]2;\h:\u:\w\007\]$PS1"
        fi
      else
        # custom prompt for other users
        PROMPT_COMMAND=__setExitStatus__
        __promptMainColor__=199
        __promptDarkColor__=242
        __firstPrompt__='$(__firstRightPrompt__; __setupFirstLeftPrompt__)\D{%Y/%m/%d (%a) %H:%M:%S}$(__shellName__)'
        __secondPrompt__='\[\033[38;5;'"$__promptMainColor__"'m\]$(__upDir__)/\W %'
        PS1="$__firstPrompt__\[\033[0m\]\n$__secondPrompt__\[\033[0m\] "
        PS2='\[\033[38;5;'"$__promptDarkColor__"'m\]> \[\033[0m\]'
      fi
    '';
  };
}
