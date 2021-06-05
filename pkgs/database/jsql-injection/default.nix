{ stdenv, lib, makeWrapper, jre, fetchurl, ... }:

stdenv.mkDerivation {
  name = "jsql-injection";

  version = "0.85";

  src = fetchurl {
    url = "https://github.com/ron190/jsql-injection/releases/download/v0.85/jsql-injection-v0.85.jar";
    sha256 = "0OsJuL3oK0CFy7F3pmtjTqM9KVqNfn8/Mwx0qPsKU5c=";
  };

  buildInputs = [
    makeWrapper
  ];

  unpackPhase = "cp $src jsql-injection.jar";

  installPhase = ''
    mkdir -p $out/{share,bin}
    cp jsql-injection.jar $out/share/
    makeWrapper ${jre}/bin/java $out/bin/jsql-injection --add-flags "-jar $out/share/jsql-injection.jar"
  '';
}
