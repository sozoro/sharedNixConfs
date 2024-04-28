{ config, pkgs, lib, ... }:
{ networking.firewall = {
    allowedUDPPorts = [ 1900 ];
    extraCommands   = ''
      iptables -A nixos-fw -m udp -p udp --sport 1900 -j nixos-fw-accept
    '';
  };
}
