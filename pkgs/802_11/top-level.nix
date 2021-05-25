{ callPackage, pkgs, ... }:

{
  inherit (pkgs) aircrack-ng;
  asleap = callPackage ./asleap {}; 
}
