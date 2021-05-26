{ stdenv, openssl, libpcap, lib, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "eapmd5pass";
  version = "2017-08-04";

  nativeBuildInputs = [ openssl libpcap ];

  src = fetchFromGitHub {
    repo = "eapmd5pass";
    owner = "joswr1ght";
    rev = "3d5551fc28931351196883b39de92afe65d27789";
    sha256 = "DYoily2dX/mbDFpQivGZZ/JMTIblooMzeoMw19w1Ky4=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp eapmd5pass $out/bin
  '';
}

