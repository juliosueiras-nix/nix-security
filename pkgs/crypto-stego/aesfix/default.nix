{ stdenv, lib, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "aesfix";

  version = "1.0.1";

  src = fetchFromGitHub {
    repo = "aesfix";
    owner = "Seabreg";
    rev = "06d85c40b06ccef5300ab8a8882efa7fe3e59a35";
    sha256 = "9JDAt+9WYLFsRpeJ7221sRPXexDiUm2vaORbSRas6wc=";
  };

  installPhase = ''
    install -Dm755 aesfix $out/bin/aesfix
  '';
}
