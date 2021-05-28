{ stdenv, lib, ncurses, bluez, libxml2, perl, fetchzip }:

stdenv.mkDerivation {
  name = "btscanner";
  version = "2.0";

  buildInputs = [
    ncurses
    bluez
    libxml2
    perl
  ];

  src = fetchzip {
    url = "https://dl.packetstormsecurity.net/wireless/btscanner-2.0.tar.bz2";
    sha256 = "vQ3n0UJFKHoNYgDdzDXkOe8M3LKAimwG4VN722tft6I=";
  };

  preBuild = ''
    substituteInPlace Makefile --replace 'Wimplicit-function-dec' 'Wimplicit-function-declaration'
    substituteInPlace btscanner.xml --replace 'file:///usr/local/etc/btscanner.dtd' "file://$out/btscanner.dtd"
    substituteInPlace btscanner.xml --replace '/usr/local/share' "$out"
  '';

  postInstall = ''
    cp oui.txt $out/
    cp btscanner.dtd $out/
  '';
}
