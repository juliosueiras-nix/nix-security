{ stdenv, lib, fetchzip, writeText }:

stdenv.mkDerivation {
  name = "stegsnow";

  version = "20130616";

  src = fetchzip {
    url = "http://www.darkside.com.au/snow/snow.zip";
    sha256 = "kf/i2JN9z5ZYKb7NW192NaeDUUBp86/DyzIbZ8S/UWo=";
    curlOpts = [ "-H" "@${writeText "headers.txt" "User-Agent: Mozilla/5.0 (X11; Linux x86_64)"}" ];
  };

  installPhase = ''
    mkdir -p $out/man/man1
    install -Dm755 snow $out/bin/snow
    cp snow.1 $out/man/man1/
  '';
}
