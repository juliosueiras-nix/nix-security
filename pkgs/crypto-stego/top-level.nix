{ callPackage, pkgs, ... }:

{
  inherit (pkgs) ccrypt steghide;
  aesfix = callPackage ./aesfix { };
  aeskeyfind = callPackage ./aeskeyfind { };
  outguess = callPackage ./outguess { };
  stegsnow = callPackage ./stegsnow { };
}
