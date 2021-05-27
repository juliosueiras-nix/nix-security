let
  packages = (import (./.) {}).defaultNix.packages.${builtins.currentSystem};
in {
  inherit (packages) wifi-80211 base;
}
