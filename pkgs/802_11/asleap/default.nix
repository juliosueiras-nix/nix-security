{ stdenv, openssl, fetchurl, libpcap, lib, fetchFromGitHub }:

let
  libxcrypt = stdenv.mkDerivation {
    name = "libxcrypt";
    version = "2.4";

    patches = [
      # Patch from https://cgit.gentoo.org/repo/gentoo.git/plain/sys-libs/libxcrypt/files/libxcrypt-2.4-glibc-2.16.patch
      ./convert-bits-to-pthread.patch
    ];

    src = fetchurl {
      url =
        "mirror://debian/pool/main/libx/libxcrypt/libxcrypt_2.4.orig.tar.gz";
      sha256 = "Qgeu45xEVMGVWyaj138z5zDq6UwgQGl2tt6Aw6PPsc0=";
    };
  };
in stdenv.mkDerivation {
  name = "asleap";
  version = "2020-11-28";

  nativeBuildInputs = [ openssl libxcrypt libpcap ];

  src = fetchFromGitHub {
    repo = "asleap";
    owner = "joswr1ght";
    rev = "254acabba34cb44608c9d2dcf7a147553d3d5ba3";
    sha256 = "MQjPup3EX7DCXY/zyroTj/+U2GIq12+VQQJD0gru7C8=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp asleap $out/bin
    cp genkeys $out/bin
  '';
}

