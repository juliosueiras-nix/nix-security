let
  packages = (import (./.) {}).defaultNix.packages.${builtins.currentSystem};
in packages.wifi-8012
