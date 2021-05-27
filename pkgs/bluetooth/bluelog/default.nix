{ stdenv, lib, fetchurl, gzip, fetchFromGitHub, bluez }:

let
  ouiArchive = fetchurl {
    url = "http://linuxnet.ca/ieee/oui.txt.gz";
    sha256 = "byhkzvzAhuBa8agUo9DKjkRH8ParcxNF+5l73pKtmi0=";
  };
in stdenv.mkDerivation {
  name = "bluelog";
  version = "2017-07-19";

  buildInputs = [ bluez.dev ];

  DESTDIR = "$(out)";

  patchPhase = ''
    cp ${ouiArchive} oui.txt.gz
    ${gzip}/bin/gunzip oui.txt.gz
    patchShebangs scripts/gen_oui.sh
  '';

  postInstall = ''
    mv $out/usr/* $out/
    rm -r $out/usr
  '';

  src = fetchFromGitHub {
    owner = "MS3FGX";
    repo = "Bluelog";
    rev = "42c915453938d2b92500fd661ea822f9b011806c";
    sha256 = "f2rufYQ6vgv+tYwNWceuTl07PFQZe1V3zBuQ7XtTDBo=";
  };
}
