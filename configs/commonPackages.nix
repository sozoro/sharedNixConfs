{ pkgs, ... }:
{ environment.systemPackages = with pkgs; [
    wget
    htop
    git
    bc
    unzip
    exfat
    binutils-unwrapped
    nix-index
    psmisc
  ];
}
