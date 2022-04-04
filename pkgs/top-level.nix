{ callPackage, lib, ... }:

let
  base = import ./base/top-level.nix { inherit callPackage; };
  wifi-80211 = import ./wifi-80211/top-level.nix { inherit callPackage; };
  bluetooth = import ./bluetooth/top-level.nix { inherit callPackage; };
  crypto-stego = import ./crypto-stego/top-level.nix { inherit callPackage; };
  database = import ./database/top-level.nix { inherit callPackage; };
  exploitation = import ./exploitation/top-level.nix { inherit callPackage; };
  forensics = import ./forensics/top-level.nix { inherit callPackage; };
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
