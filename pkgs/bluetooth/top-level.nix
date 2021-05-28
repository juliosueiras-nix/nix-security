{ callPackage, pkgs, ... }:

let
  oldBluez = callPackage ./oldBluez {};
in {
  inherit (pkgs) bluez crackle ubertooth;
  bluelog = callPackage ./bluelog { };
  blueranger = callPackage ./blueranger {  inherit oldBluez; };
  bluesnarfer = callPackage ./bluesnarfer { };
  bluez-hcidump = oldBluez;
  btscanner = callPackage ./btscanner { };
  redfang = callPackage ./redfang { };
  spooftooph = callPackage ./spooftooph { };
}
