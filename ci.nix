let
  packages = (import (./.) { }).defaultNix.packages.${builtins.currentSystem};
in {
  base = packages.base; 
  wifi-80211 = packages.wifi-80211;
  bluetooth = packages.bluetooth;
  crypto-stego = packages.crypto-stego;
  database = packages.database;
  exploitation = packages.exploitation;
  forensics = packages.forensics;
}

