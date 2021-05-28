{ stdenv, lib, fetchurl, gzip, fetchFromGitHub, bluez }:

stdenv.mkDerivation {
  name = "bluesnarfer";
  version = "2020-10-22";

  buildInputs = [ bluez.dev ];

  src = fetchFromGitHub {
    owner = "kimbo";
    repo = "bluesnarfer";
    rev = "0144ddef1181177f621fd82935318df2fd255198";
    sha256 = "dew1dv1PnreifF/MdW++BvVD9hbV6dchbOi00q9tT9Y=";
  };

  installPhase = ''
    install -Dm755 bluesnarfer $out/bin/bluesnarfer
  '';
}
