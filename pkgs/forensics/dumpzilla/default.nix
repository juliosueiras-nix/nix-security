{ stdenv, fetchFromGitHub, installShellFiles, python3, ... }:

stdenv.mkDerivation rec {
  pname = "dumpzilla";
  version = "2021-03-11";

  src = fetchFromGitHub {
    owner = "Busindre";
    repo = pname;
    rev = "ec337da722441c7480f280b14c273718fabc6c96";
    sha256 = "oZnsKkH1IWEWjxIqhgMAZ6sqn+OGxK5d27zI2TeT4ik=";
  };

  installPhase = ''
    mkdir -p $out/{bin,etc/bash_completion.d}
    cp dumpzilla $out/etc/bash_completion.d/
    cp dumpzilla.py $out/bin/dumpzilla
    chmod +x $out/bin/dumpzilla
    sed -i 's;/usr/bin/env python;${python3.withPackages(ps: [ ps.lz4 ])}/bin/python;g' $out/bin/dumpzilla
  '';
}
