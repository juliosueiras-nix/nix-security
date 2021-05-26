{ callPackage, ... }:

{
  wifi-80211 = callPackage ./wifi-80211/top-level.nix {};
}
