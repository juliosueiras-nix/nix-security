{ stdenv, net-snmp, talloc, openssl, lib, fetchFromGitLab }:

let
  version = "2021-04-22";
in stdenv.mkDerivation rec {
  pname = "freeradius-wpe"; inherit version;

  buildInputs = [ net-snmp talloc openssl ];

  src = fetchFromGitLab {
    owner = "kalilinux/packages";
    repo = "freeradius-wpe";
    rev = "317117c15dd1483b02776af8560df426a15d1516";
    sha256 = "QRY6kz6TSqQOQKrIvW/lHCtF2aLFJUdvbkYYWdA/3F8=";
  };
}

