{ stdenv, lib, fetchFromGitLab, ncurses, bluez }:

let
  src = fetchFromGitLab {
    owner = "kalilinux/packages";
    repo = "spooftooph";
    rev = "e6e8758315bbc1b5ea099f12aa3cf5fb5e6e9235";
    sha256 = "+GSXbOC/4wPkqem7iykSsQb6MHikMAvZ0c8lbDwf2oc=";
  };
in stdenv.mkDerivation {
  name = "spooftooph";
  version = "0.5.2";

  inherit src;

  preInstall = ''
    mkdir -p $out/bin
    substituteInPlace makefile --replace '/usr/bin' "$out/bin/spooftooph"
  '';

  buildInputs = [ bluez ncurses ];
}
