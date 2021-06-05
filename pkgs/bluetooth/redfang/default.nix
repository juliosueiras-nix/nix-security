{ stdenv, lib, fetchFromGitLab, bluez }:

let
  src = fetchFromGitLab {
    owner = "kalilinux/packages";
    repo = "redfang";
    rev = "652d8999c9ef8e37e89c2ee7169179cadee73d67";
    sha256 = "cDUhLHJTE7w5H1zBctndx8ClD0PC/kaEX+62YB6Gwkg=";
  };
in
stdenv.mkDerivation {
  name = "redfang";

  inherit src;

  patches = [
    "${src}/debian/patches/Fix-format-security-error.patch"
  ];

  buildInputs = [ bluez ];

  installPhase = ''
    install -Dm755 fang $out/bin/fang
  '';
}
