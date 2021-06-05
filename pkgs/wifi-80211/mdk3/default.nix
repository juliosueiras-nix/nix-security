{ stdenv, lib, fetchurl, mdk4, fetchFromGitHub }:

mdk4.overrideAttrs (old: {
  name = "mkd3";

  src = fetchFromGitHub {
    repo = "mdk3";
    owner = "aircrack-ng";
    rev = "3be47e2e02d311e6746bd6d38c73ec957300aba0";
    sha256 = "gh8tq3CxYb+qpeqxvKnD3d+qD6uPsBeXSkr42gn7Puc=";
  };
})

