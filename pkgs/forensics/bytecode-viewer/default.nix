{ stdenv, lib, makeWrapper, fetchurl, jre, ... }:

let
  version = "2.10.16";
in stdenv.mkDerivation {
  name = "bytecode-viewer";
  inherit version;

  buildInputs = [ makeWrapper ];

  src = fetchurl {
    url = "https://github.com/Konloch/bytecode-viewer/releases/download/v2.10.16/Bytecode-Viewer-2.10.16.jar";
    sha256 = "daQUTvNRM0pMKdVciBEUErEgK+9hzH/TIjrJVpw7w60=";
  };

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out/{bin,share/java}
    cp $src $out/share/java/bytecode-viewer.jar
    makeWrapper ${jre}/bin/java $out/bin/bytecode-viewer --add-flags "-jar $out/share/java/bytecode-viewer.jar" 
  '';
}
