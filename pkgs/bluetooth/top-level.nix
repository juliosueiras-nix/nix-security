{ callPackage, pkgs, ... }:

let
  oldBluez = callPackage ./oldBluez {};
in {
  bluelog = callPackage ./bluelog { };
  blueranger = callPackage ./blueranger {  inherit oldBluez; };
  bluesnarfer = callPackage ./bluesnarfer { };
}
