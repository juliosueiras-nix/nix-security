{ callPackage, pkgs, ... }:

{
  inherit (pkgs) aircrack-ng bully cowpatty mdk4 hashcat iw kismet macchanger reaverwps wifite2;
  asleap = callPackage ./asleap { };
  eapmd5pass = callPackage ./eapmd5pass { };
  fern-wifi-cracker = callPackage ./fern-wifi-cracker { };
  freeradius-wpe = callPackage ./freeradius-wpe { };
  hostapd-wpe = callPackage ./hostapd-wpe { };
  mdk3 = callPackage ./mdk3 { };
  wifi-honey = callPackage ./wifi-honey { };
}
