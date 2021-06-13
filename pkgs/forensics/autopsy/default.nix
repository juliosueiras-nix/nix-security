{ stdenv, fetchzip, lib, callPackage, jdk8, makeWrapper, ... }:

let
  version = "4.18.0";
  sleuthkit-jni = callPackage ./sleuthkit-jni.nix {};
in stdenv.mkDerivation {
  name = "autopsy";
  inherit version;

  buildInputs = [ makeWrapper ];

  src = fetchzip {
    url = "https://github.com/sleuthkit/autopsy/releases/download/autopsy-${version}/autopsy-${version}.zip";
    sha256 = "fgPGX8BI0O0SzpSLkIp1mG6RSwWvOe/f4ZuFhU0Bel4=";
  };

  installPhase = ''
    mkdir -p $out
    rm -rf autopsy/7-Zip
    rm -rf autopsy/aLeapp
    rm -rf autopsy/ESEDatabaseView
    rm -rf autopsy/ewfexport_exec
    rm -rf autopsy/gstreamer
    rm -rf autopsy/iLeapp
    rm -rf autopsy/ImageMagick*
    rm autopsy/markmckinnon/*.exe
    rm autopsy/markmckinnon/*_macos
    rm -rf autopsy/photorec_exec
    rm -rf autopsy/plaso
    rm -rf autopsy/rr
    rm -rf autopsy/rr-full
    rm -rf autopsy/solr*
    rm -rf autopsy/Tesseract-OCR
    rm -rf autopsy/tsk_logical_imager
    rm -rf autopsy/Volatility
    rm -rf autopsy/yara/*.exe

    cp -r * $out/

    cp ${sleuthkit-jni}/share/java/*.jar $out/autopsy/modules/ext/

    chmod +x $out/bin/autopsy

    find . -name "*.dll" -delete

    sed -i 's;APPNAME=`basename "$PRG"`;APPNAME=autopsy;g' $out/bin/autopsy

    wrapProgram $out/bin/autopsy --add-flags "--jdkhome ${jdk8.jre}"
  '';
}
