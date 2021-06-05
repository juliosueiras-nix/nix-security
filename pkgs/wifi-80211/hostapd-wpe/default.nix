{ stdenv, lib, fetchurl, hostapd }:

hostapd.overrideAttrs (old: {
  name = "hostapd-wpe";

  patches = old.patches ++ [
    (fetchurl {
      url = "https://raw.githubusercontent.com/aircrack-ng/aircrack-ng/dfacc5d5e7ae315a5ab42dedb32d5921ada9df3b/patches/wpe/hostapd-wpe/hostapd-wpe.patch";
      sha256 = "TBbG3PskPAR6DkHaMwtjwjL3L4wPRBee7xBRQmKMzQY=";
    })
  ];
})

