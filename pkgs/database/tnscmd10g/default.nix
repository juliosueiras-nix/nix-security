{ stdenv, lib, makeWrapper, fetchFromGitLab, perl, ... }:

stdenv.mkDerivation {
  name = "tnscmd10g";

  src = fetchFromGitLab {
    repo = "tnscmd10g";
    owner = "kalilinux/packages";
    rev = "742e7665b0ff99722c6092eab5fab83e48372c6a";
    sha256 = "DOIOImRX1R4aYmu+EvEK7V8SAzKVs1bbmqkU2+AYg3s=";
  };

  version = "1.3";

  buildInputs = [
    makeWrapper
  ];

  installPhase = ''
    install -Dm755 tnscmd10g $out/bin/tnscmd10g
    substituteInPlace $out/bin/tnscmd10g --replace '/usr/bin/perl' "${perl}/bin/perl"
  '';
}
