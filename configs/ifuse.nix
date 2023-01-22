{ config, pkgs, lib, ... }:
{ environment.systemPackages = with pkgs; [ libimobiledevice ifuse ];
  services.usbmuxd.enable = true;

  nixpkgs.config = {
    packageOverrides = oldpkgs: let newpkgs = oldpkgs.pkgs; in {
      libimobiledevice = newpkgs.stdenv.mkDerivation rec {
        ### default
        pname = "libimobiledevice";
        version = "unstable-2021";

        src = newpkgs.fetchFromGitHub {
          owner = pname;
          repo = pname;
          rev = "ca324155f8b33babf907704828c7903608db0aa2";
          sha256 = "sha256-Q7THwld1+elMJQ14kRnlIJDohFt7MW7JeyIUGC0k52I=";
        };

        ### latest
        # pname = "libimobiledevice";
        # version = "unstable-2022";

        # src = newpkgs.fetchgit {
        #   url = "https://github.com/libimobiledevice/libimobiledevice";
        #   rev = "7a0aedc97c66025d678afee66e735b6e3dcf0b9c";
        #   sha256 = "1ab5nmv0dpdm8lki88c3dwk8hkx1jfxam7bqcl7nidghg6iv3wwc";
        # };

        # PACKAGE_VERSION = version;

        ### 1.2.0
        # pname = "libimobiledevice";
        # version = "1.2.0";

        # src = newpkgs.fetchFromGitHub {
        #   owner = pname;
        #   repo = pname;
        #   rev = version;
        #   sha256 = "SXbvWmq+f5s4MPPpER9/aNm0d00igitepHsiTKOjYJI=";
        # };

        ### 1.3.0
        # pname = "libimobiledevice";
        # version = "1.3.0";

        # src = newpkgs.fetchFromGitHub {
        #   owner = pname;
        #   repo = pname;
        #   rev = version;
        #   sha256 = "adwrmq0Iaz9ZP34xRy0Ajl+ANFgRBTODNqpY8i4ceMo=";
        # };

        outputs = [ "out" "dev" ];

        nativeBuildInputs = with newpkgs; [
          autoreconfHook
          libtool
          pkg-config
        ];

        propagatedBuildInputs = with newpkgs; [
          glib
          gnutls
          libgcrypt
          libplist
          libtasn1
          libusbmuxd
        ];

        configureFlags = [ "--disable-openssl" "--without-cython" ];
      };

      ifuse = newpkgs.stdenv.mkDerivation rec {
        ### default
        # pname = "ifuse";
        # version = "1.1.4";

        # src = newpkgs.fetchFromGitHub {
        #   owner = "libimobiledevice";
        #   repo = pname;
        #   rev = version;
        #   sha256 = "1r12y3h1j7ikkwk874h9969kr4ksyamvrwywx19ml6rsr01arw84";
        # };

        ### latest
        pname = "ifuse";
        version = "unstable-2022-04-04";

        src = newpkgs.fetchFromGitHub {
          owner = "libimobiledevice";
          repo = pname;
          rev = "33434dec21198de11cea78325321d55ebb7bd71f";
          sha256 = "BPGsAsg6G1pT6NzzvKvyepI8k0kJkoMmnzMeGeDwIuQ=";
        };

        nativeBuildInputs = with newpkgs; [ autoreconfHook pkg-config fuse usbmuxd libimobiledevice ];
      };

      libusbmuxd = newpkgs.stdenv.mkDerivation rec {
        ### default
        pname = "libusbmuxd";
        version = "unstable-2021-02-06";

        src = newpkgs.fetchFromGitHub {
          owner = "libimobiledevice";
          repo = pname;
          rev = "3eb50a07bad4c2222e76df93b23a0161922150d1";
          sha256 = "sha256-pBPBgE6s8JYKJYEV8CcumNki+6jD5r7HzQ0nZ8yQLdM=";
        };

        ### 1.1.1
        # pname = "libusbmuxd";
        # version = "2.0.2";

        # src = newpkgs.fetchFromGitHub {
        #   owner = "libimobiledevice";
        #   repo = pname;
        #   rev = version;
        #   sha256 = "yd1pihlu1Kpk6J3kC3oF7UGQcWzgGhw8NZPNHq3+N40=";
        # };

        nativeBuildInputs = with newpkgs; [ autoreconfHook pkg-config ];
        buildInputs = with newpkgs; [ libplist ];
      };
    };
  };
}
