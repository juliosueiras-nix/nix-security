{ stdenv, lib, makeWrapper, jre, fetchFromGitLab, fetchzip, perl, fetchurl, buildPerlPackage, perlPackages, ... }:

let
  src = fetchFromGitLab {
    repo = "sqlsus";
    owner = "kalilinux/packages";
    rev = "05c9c0fdbcbd0c52768e61b98f6b19fadafb6f04";
    sha256 = "0jtij3tUSQDi3ZNR3CoiXzFYm98SJeZW44KXzXlgZR8=";
  };

  HTMLLinkExtractor = buildPerlPackage {
    pname = "HTML-LinkExtractor";
    version = "0.13";
    src = fetchurl {
      url = "mirror://cpan/authors/id/P/PO/PODMASTER/HTML-LinkExtractor-0.13.tar.gz";
      sha256 = "8f42fd3838fe39b2ab02ebf098f43b15fa701c56b93aa317fe9f3aa006ad9fc1";
    };
    propagatedBuildInputs = [ perlPackages.HTMLParser ];
    meta = { };
  };
in
stdenv.mkDerivation {
  name = "sqlsus";

  inherit src;
  version = "0.7.2";

  preConfigure = ''
    rm -r debian
  '';

  patches = [
    "${src}/debian/patches/drop-defined-array.patch"
  ];

  buildInputs = [
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/{bin,share/sqlsus}
    cp -r * $out/share/sqlsus/
    substituteInPlace $out/share/sqlsus/sqlsus --replace '/usr/bin/perl -w' "${perl.withPackages(p: with p; [ LWPUserAgent DBI Switch HTMLLinkExtractor DBDSQLite TermReadLineGnu ])}/bin/perl"
    makeWrapper $out/share/sqlsus/sqlsus $out/bin/sqlsus --run "cd $out/share/sqlsus"
  '';
}
