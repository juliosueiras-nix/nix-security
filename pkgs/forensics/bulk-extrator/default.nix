# from: https://github.com/NixOS/nixpkgs/pull/82265
{ stdenv, fetchFromGitHub, autoreconfHook, flex, openssl, zlib }:

stdenv.mkDerivation rec {
  pname = "bulk_extractor";
  version = "2.0.0-dev";

  src = fetchFromGitHub {
    owner = "simsong";
    repo = pname;
    rev = "980da76d0e2d639a4096c851f72d7e7ce3ea44f1";
    sha256 = "Ld1nzDoWqzNKat3+KrUf9LneIZDP1Wfj2aJuIlQuqIo=";
    fetchSubmodules = true;
  };

  configureFlags = ["--disable-BEViewer"];

  enableParallelBuilding = true;
  nativeBuildInputs = [autoreconfHook];
  buildInputs = [flex openssl zlib];
}
