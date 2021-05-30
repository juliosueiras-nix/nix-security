{ stdenv, lib, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "aeskeyfind";

  version = "1.0";

  src = fetchFromGitHub {
    repo = "aeskeyfind";
    owner = "makomk";
    rev = "f6019ed91f0327e6f73e858f7dc186004a039eda";
    sha256 = "ERNJz9c1AVgmDf2b+Y7TluvT0UycC4NxbMOP2Lj77TY=";
  };

  installPhase = ''
    install -Dm755 aeskeyfind $out/bin/aeskeyfind
  '';
}
