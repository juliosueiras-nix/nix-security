{ callPackage, pkgs, ... }:

let
  openjfx8 = callPackage ./openjfx8 {};
in {
  inherit (pkgs) afflib apktool;
  autopsy = callPackage ./autopsy {
    inherit openjfx8;
  };
}
