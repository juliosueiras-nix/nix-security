{ callPackage, lib, ... }:

let
  base = callPackage ./base/top-level.nix { };
  wifi-80211 = callPackage ./wifi-80211/top-level.nix { };
  bluetooth = callPackage ./bluetooth/top-level.nix { };
  crypto-stego = callPackage ./crypto-stego/top-level.nix { };
  database = callPackage ./database/top-level.nix { };
  exploitation = callPackage ./exploitation/top-level.nix { };
  forensics = callPackage ./forensics/top-level.nix { };
  genAttrPkgs = pname: packages: lib.mapAttrs' (k: v: { name = "${pname}.${k}"; value = v;}) packages;
in ( 
  (genAttrPkgs "base" base) //
  (genAttrPkgs "wifi-80211" wifi-80211) //
  (genAttrPkgs "bluetooth" bluetooth) //
  (genAttrPkgs "crypto-stego" crypto-stego) //
  (genAttrPkgs "database" database) //
  (genAttrPkgs "exploitation" exploitation) //
  (genAttrPkgs "forensics" forensics)
)
