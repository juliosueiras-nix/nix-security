{ callPackage, pkgs, ... }:

let
  openjfx8 = callPackage ./openjfx8 {};
in {
  inherit (pkgs) afflib apktool cabextract chkrootkit;
  autopsy = callPackage ./autopsy {
    inherit openjfx8;
  };

  bulk-extrator = callPackage ./bulk-extrator {};
  bytecode-viewer = callPackage ./bytecode-viewer {};
  creddump7 = callPackage ./creddump7 {};
  dc3dd = callPackage ./dc3dd {};
}
