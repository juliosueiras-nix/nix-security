{ stdenv, lib, ncurses, bluez, libxml2, perl }:

stdenv.mkDerivation {
  name = "btscanner";
  version = "2.0";

  buildInputs = [
    ncurses
    bluez
    libxml2
    perl
  ];

  src = fetchTarball {
    url = "https://dl.packetstormsecurity.net/wireless/btscanner-2.0.tar.bz2";
    sha256 = "18mpbxmxnyskw436r2l0nbf0rvrrwhswrp80c86pla258b8yf3dx";
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
