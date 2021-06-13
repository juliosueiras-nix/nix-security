{ callPackage, pkgs, ... }:

{
  inherit (pkgs) afflib apktool;
  autopsy = callPackage ./autopsy {};
}
