{ callPackage, ... }:

{
  "802_11" = callPackage ./802_11/top-level.nix {};
}
