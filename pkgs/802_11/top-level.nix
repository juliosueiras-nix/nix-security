{ callPackage, pkgs, ... }:

{
  inherit (pkgs) aircrack-ng bully cowpatty;
  asleap = callPackage ./asleap {}; 
  eapmd5pass = callPackage ./eapmd5pass {};
  fern-wifi-cracker = callPackage ./fern-wifi-cracker {};
}
