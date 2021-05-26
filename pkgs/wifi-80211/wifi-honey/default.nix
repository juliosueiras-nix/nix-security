{ stdenv, lib, makeWrapper, screen, iproute, aircrack-ng, procps, kmod, utillinux, wirelesstools, fetchFromGitLab }:

stdenv.mkDerivation {
  name = "wifi-honey";

  src = fetchFromGitLab {
    owner = "kalilinux/packages";
    repo = "wifi-honey";
    rev = "c250fae873fa49c44dc845fe5ff4f8d1c6cfea26";
    sha256 = "6RcZgmFMJ6TEEX+WOHRZ47Z49/T7q4/zZ9+yEblY+zE=";
  };

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    sed 's;screen_wifi_honey.rc;$TMPDIR/screen_wifi_honey.rc;' wifi_honey.sh | sed "s;wifi_honey_template.rc;$out/wifi_honey_template.rc;" > $out/wifi_honey.sh
    chmod +x $out/wifi_honey.sh
    makeWrapper $out/wifi_honey.sh $out/bin/wifi-honey --set PATH "$PATH:${lib.makeBinPath [ aircrack-ng wirelesstools screen iproute procps kmod utillinux]}"
    cp wifi_honey_template.rc $out/
  '';
}
