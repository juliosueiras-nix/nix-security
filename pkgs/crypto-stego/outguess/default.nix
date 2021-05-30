# Adapted from https://github.com/NixOS/nixpkgs/pull/101824
{ stdenv, lib, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "outguess";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "resurrecting-open-source-projects";
    repo = "outguess";
    rev = version;
    sha256 = "1wz0cpwg0r8sz46klhd78pmcbncmi2ih4r4ydb60l5vpjr1xf07j";
  };

  preConfigure = ''
    pushd .
    cd jpeg-6b-steg && ln -s jconfig.cfg jconfig.h 
    popd
  '';

  preInstall = ''
    mkdir -p $out/{bin,man/man1}
  '';
}
