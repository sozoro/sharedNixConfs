{ config, pkgs, lib, ... }:
{ environment = {
    systemPackages = [ pkgs.git ];
    variables.GIT_ASKPASS = "";
  };

  programs.git = {
    enable = true;
    config = {
      core.excludesfile = "/etc/gitignore_global";
    };
  };

  environment.etc."gitignore_global".text = ''
    # Swap
    [._]*.s[a-v][a-z]
    # comment out the next line if you don't need vector files
    !*.svg
    [._]*.sw[a-p]
    [._]s[a-rt-v][a-z]
    [._]ss[a-gi-z]
    [._]sw[a-p]

    # Session
    Session.vim
    Sessionx.vim

    # Temporary
    .netrwhist
    *~
    # Auto-generated tag files
    tags
    # Persistent undo
    [._]*.un~

    # Vim typos
    :
    :w
    :w:w
    ::
    ;
    ;w
    ]

    # Nix
    # Ignore build outputs from performing a nix-build or `nix build` command
    result
    result-*

    # Ignore automatically generated direnv output
    .direnv

    # Ignore NixOS interactive test driver history
    **/.nixos-test-history

    # Haskell
    dist
    dist-*
    cabal-dev
    *.o
    *.hi
    *.hie
    *.chi
    *.chs.h
    *.dyn_o
    *.dyn_hi
    .hpc
    .hsenv
    .cabal-sandbox/
    cabal.sandbox.config
    *.prof
    *.aux
    *.hp
    *.eventlog
    .stack-work/
    cabal.project.local
    cabal.project.local~
    .HTF/
    .ghc.environment.*

    # Python
    # Byte-compiled / optimized / DLL files
    __pycache__/
    *.py[codz]
    *$py.class

    .env
    .venv
    venv/
    env.bak/
    venv.bak/
    .pytype/
    cython_debug/
    .ruff_cache/
    .pypirc
    .hypothesis/
    .pytest_cache/
    .mypy_cache/
    .pymon
  '';
}
