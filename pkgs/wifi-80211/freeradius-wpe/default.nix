{ stdenv, net-snmp, talloc, openssl, lib, fetchFromGitLab }:

let
  version = "2021-04-22";
  src = fetchFromGitLab {
    owner = "kalilinux/packages";
    repo = "freeradius-wpe";
    rev = "317117c15dd1483b02776af8560df426a15d1516";
    sha256 = "QRY6kz6TSqQOQKrIvW/lHCtF2aLFJUdvbkYYWdA/3F8=";
  };
in stdenv.mkDerivation rec {
  pname = "freeradius-wpe"; inherit src version;

  buildInputs = [ net-snmp talloc openssl ];

  patches = [
    "${src}/debian/patches/debian-local/0001-Rename-radius-to-freeradius.patch"
    "${src}/debian/patches/0002-gitignore.diff.patch"
    "${src}/debian/patches/0006-jradius.diff.patch"
    "${src}/debian/patches/0009-dhcp-sqlipool-Comment-out-mysql.patch"
    "${src}/debian/patches/debian-local/0010-version.c-disable-openssl-version-check.patch"
    "${src}/debian/patches/dont-install-tests.diff"
    "${src}/debian/patches/mkdirp.diff"
    "${src}/debian/patches/snakeoil-certs.diff"
    "${src}/debian/patches/freeradius-wpe.patch"
  ];
}

