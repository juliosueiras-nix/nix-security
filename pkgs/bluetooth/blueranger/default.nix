{ stdenv, makeWrapper, ncurses, oldBluez, lib, fetchFromGitLab }:

let
  src = fetchFromGitLab {
    owner = "kalilinux/packages";
    repo = "blueranger";
    rev = "866558f73a71eee7a22db5740a72523ba8db3b71";
    sha256 = "lcsiJUg5t+VlhIU9gCJ/Hh2zxb7sLQx3MCZwg44Rk0o=";
  };
in stdenv.mkDerivation {
  name = "blueranger";

  inherit src;

  patches = [
    "${src}/debian/patches/update-help-example.patch"
  ];

  buildInputs = [ makeWrapper ];

  installPhase = ''
    install -Dm755 blueranger.sh $out/bin/blueranger.sh
    substituteInPlace $out/bin/blueranger.sh --replace /bin/true true
    wrapProgram $out/bin/blueranger.sh --set PATH "$PATH:${lib.makeBinPath [ oldBluez ncurses ]}"
  '';
}
