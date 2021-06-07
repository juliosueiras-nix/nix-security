{ callPackage, ... }:

{
  wifi-80211 = callPackage ./wifi-80211/top-level.nix { };
  base = callPackage ./base/top-level.nix { };
  bluetooth = callPackage ./bluetooth/top-level.nix { };
  crypto-stego = callPackage ./crypto-stego/top-level.nix { };
  database = callPackage ./database/top-level.nix { };
  exploitation = callPackage ./exploitation/top-level.nix { };
}
