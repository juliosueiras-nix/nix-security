{ callPackage, lib, ... }:

let
  base = callPackage ./base/top-level.nix { };
  wifi-80211 = callPackage ./wifi-80211/top-level.nix { };
  bluetooth = callPackage ./bluetooth/top-level.nix { };
  crypto-stego = callPackage ./crypto-stego/top-level.nix { };
  database = callPackage ./database/top-level.nix { };
  exploitation = callPackage ./exploitation/top-level.nix { };
  forensics = callPackage ./forensics/top-level.nix { };
  test = lib.mapAttrs' (k: v: { name = "base.${k}"; value = v;}) base;
in test#({
#  inherit base wifi-80211 bluetooth crypto-stego database exploitation forensics;
#})
