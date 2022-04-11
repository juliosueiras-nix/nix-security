{ callPackage, pkgs, lib, ... }:

let
  base = import ./base/top-level.nix { inherit callPackage pkgs; };
  wifi-80211 = import ./wifi-80211/top-level.nix { inherit callPackage pkgs; };
  bluetooth = import ./bluetooth/top-level.nix { inherit callPackage pkgs; };
  crypto-stego = import ./crypto-stego/top-level.nix { inherit callPackage pkgs; };
  database = import ./database/top-level.nix { inherit callPackage pkgs; };
  exploitation = import ./exploitation/top-level.nix { inherit callPackage pkgs; };
  forensics = import ./forensics/top-level.nix { inherit callPackage pkgs; };
  genAttrPkgs = pname: packages: lib.mapAttrs' (k: v: { name = "${pname}.${k}"; value = v;}) packages;
in ( 
  (genAttrPkgs "base" base) // 
  (genAttrPkgs "wifi-80211" wifi-80211) //
  (genAttrPkgs "bluetooth" bluetooth) //
  (genAttrPkgs "crypto-stego" crypto-stego) //
  (genAttrPkgs "database" database) //
  (genAttrPkgs "exploitation" exploitation) //
  (genAttrPkgs "forensics" forensics)
#  {
#    base = base; 
#    wifi-80211 = wifi-80211;
#    bluetooth = bluetooth;
#    crypto-stego = crypto-stego;
#    database = database;
#    exploitation = exploitation;
#    forensics = forensics;
#  }
)
