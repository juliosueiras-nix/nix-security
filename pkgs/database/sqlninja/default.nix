{ stdenv, lib, makeWrapper, jre, fetchFromGitLab, perl, buildPerlPackage, fetchurl, ... }:

let
  NetPacket = buildPerlPackage {
    pname = "NetPacket";
    version = "1.7.2";
    src = fetchurl {
      url = "mirror://cpan/authors/id/Y/YA/YANICK/NetPacket-1.7.2.tar.gz";
      sha256 = "e3af614a1b1ef4cbeaf83db32081d8bcb8d812bb6dbe4660aba3e4081e9f145b";
    };
    meta = {
      homepage = "https://github.com/yanick/netpacket";
      description = "Assemble/disassemble network packets at the protocol level";
      license = lib.licenses.artistic2;
    };
  };
in
stdenv.mkDerivation {
  name = "sqlninja";

  version = "0.2.6";

  buildInputs = [
    makeWrapper
  ];

  src = fetchFromGitLab {
    repo = "sqlninja";
    owner = "kalilinux/packages";
    rev = "f5142ba63a1d0428ac35fb6016f3973863d0d20b";
    sha256 = "LfttMsGOBzEKqhsXHs0BSv5/pU9aIkgSCiyWw2ytn24=";
  };

  installPhase = ''
    mkdir -p $out/{share/sqlninja/apps,bin}
    cp sqlninja  $out/bin/
    cp apps/* $out/share/sqlninja/apps/
    substituteInPlace $out/bin/sqlninja --replace 'apps/' "$out/share/sqlninja/apps/" --replace '/usr/bin/env perl' "${perl.withPackages(p: with p; [ NetPacket IOSocketSSL ])}/bin/perl"
  '';
}
