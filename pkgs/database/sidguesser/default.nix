{ stdenv, lib, fetchFromGitLab, ... }:

stdenv.mkDerivation {
  name = "sidguesser";

  version = "1.0.5";

  src = fetchFromGitLab {
    repo = "sidguesser";
    owner = "kalilinux/packages";
    rev = "2d26595753a85e6030edd726d4642d0efc22f930";
    sha256 = "zHZ2EkUkzbaKzVNy5lR9h0bXQqNhGMYiFqSGjCK4xNw=";
  };

  installPhase = ''
    install -Dm 755 sidguess $out/bin/sidguess
  '';
}
