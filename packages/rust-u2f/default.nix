{ lib, rustPlatform, fetchFromGitHub
, pkg-config
, udev, openssl
, libclang
, linuxHeaders, glibc
}:

rustPlatform.buildRustPackage rec {
  pname   = "rust-u2f";
  version = "v0.4.2";

  src = fetchFromGitHub {
    owner  = "danstiner";
    repo   = "rust-u2f";

    # master (2022/09/27)
    # rev    = "a19b0084d6367d5cf9dd050598dfda35327e4c6c";
    # sha256 = "i0M86u3QuxwdS8KfF466GuJfoVc7I0OcNFfxHi9uZuE=";

    # latest release
    rev    = "60c6ecb2e6ac868cc65b1b6d40ff5c6616b02925";
    sha256 = "a0tq+nPePPIDQPfTLXWdzZe075rHmvQ4n/iKmwm6j0w=";
  };

  # cargoSha256 = lib.fakeSha256;
  cargoSha256 = "sha256-MsW/1mG80WAdwH/ciQALvv1d3AUsK3Jf9k9AL4dAOlA=";

  nativeBuildInputs = [
    pkg-config
  ];
  
  buildInputs = [
    udev
    openssl
  ];

  # ref: "LIBCLANG_PATH environment variable from inside .nix expression #52447"
  #      https://github.com/NixOS/nixpkgs/issues/52447
  LIBCLANG_PATH = "${libclang.lib}/lib";

  # include <linux/uhid.h> for `uhid-sys` package
  # ref: https://nixos.wiki/wiki/Rust
  BINDGEN_EXTRA_CLANG_ARGS = (builtins.map (x: ''-I"${x}/include"'') [
    linuxHeaders
    glibc.dev
  ]) ++ [
    ''-I"${libclang.lib}/lib/clang/${libclang.version}/include"''
  ];

  meta = with lib; {
    description = "A software-only Universal 2nd Factor token. Supports Google Chrome and Firefox on Linux. Written in Rust.";
    homepage    = "https://github.com/danstiner/rust-u2f";
    license     = licenses.mit;
    platforms   = platforms.linux;
  };
}
