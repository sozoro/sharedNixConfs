{ config, pkgs, lib, ... }:
let
  packagePath = ./rust-u2f;
  packageName = "rust-u2f";
  install     = true;
  setup       = true;
  package     = pkgs."${packageName}";
in
  { nixpkgs.config = {
      packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in{
        "${packageName}" = newpkgs.callPackage packagePath {
        };
      };
    };
    environment.systemPackages = if install then [ pkgs."${packageName}" ] else [];

    systemd = {
      services.softu2f = {
        description   = "Software-only U2F Emulation Service";
        wants         = [ "softu2f.socket" ];
        wantedBy      = [ "default.target" ];
        serviceConfig = {
          Type           = "simple";
          ExecStart      = "${package}/bin/softu2f-system-daemon";
          PrivateNetwork = true;
          PrivateTmp     = true;
        };
      };
      sockets.softu2f = {
        wantedBy      = [ "sockets.target" ];
        listenStreams = [ "/run/softu2f/softu2f.sock" ];
      };
      user.services.softu2f = {
        description   = "Software-only U2F Emulation Service";
        wantedBy      = [ "default.target" ];
        serviceConfig = {
          Type            = "simple";
          ExecStart       = "${package}/bin/softu2f-user-daemon";
          NoNewPrivileges = true;
          PrivateTmp      = true;
        };
      };
    };
  }
