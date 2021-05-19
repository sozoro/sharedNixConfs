{ config, pkgs, lib, ... }:
{ networking.firewall.extraCommands = ''
    iptables -A nixos-fw -m udp -p udp --sport 1900 -j nixos-fw-accept
  '';
}
