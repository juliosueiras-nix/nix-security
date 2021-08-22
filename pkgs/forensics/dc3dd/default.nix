{ stdenv, automake111x, autoreconfHook, fetchurl, unzip, ... }:

stdenv.mkDerivation {
  name = "dc3dd";

  buildInputs = [ automake111x unzip autoreconfHook ];

  src = fetchurl {
    url = "mirror://sourceforge/dc3dd/dc3dd/7.2.646/dc3dd%207.2.646/dc3dd-7.2.646.zip";
    sha256 = "xOMl5cva5J44VbCEnqYv7RfVU0KHJHRc6lP+bZH9K38=";
  };
  sourceRoot = [ "dc3dd-7.2.646" ];

  unpackPhase = ''
    unzip -qq $src || true
  '';

  patchPhase = ''
    chmod +x build-aux/git-version-gen
    chmod +x configure
    patch -p1 < ${./glibc-change.patch}
  '';
}
