{ stdenv, lib, makeWrapper, jre, fetchFromGitLab, wine, ... }:

stdenv.mkDerivation {
  name = "sqldict";

  version = "2.1";

  buildInputs = [
    makeWrapper
  ];

  src = fetchFromGitLab {
    repo = "sqldict";
    owner = "kalilinux/packages";
    rev = "e28755ae7aee270beb305eb29c1f07e9206b8fe6";
    sha256 = "ZqFTXdokDjZxf/8pOCJre/HnzcFAuKzkkuEZqLZQF0o=";
  };

  installPhase = ''
    mkdir -p $out/{share,bin}
    cp sqldict.exe $out/share/
    makeWrapper ${wine}/bin/wine $out/bin/sqldict --add-flags "$out/share/sqldict.exe"
  '';
}
