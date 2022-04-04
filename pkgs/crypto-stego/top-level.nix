{ callPackage, pkgs, ... }:

{
  inherit (pkgs) ccrypt;
  aesfix = callPackage ./aesfix { };
  aeskeyfind = callPackage ./aeskeyfind { };
  outguess = callPackage ./outguess { };
  stegsnow = callPackage ./stegsnow { };
  steghide = callPackage ./steghide { };
}
