let
  packages = (import (./.) { }).defaultNix.packages.${builtins.currentSystem};
in
(packages.wifi-80211 // packages.base // packages.bluetooth // packages.database // packages.exploitation)
