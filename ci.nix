let
  packages = (import (./.) { }).defaultNix.packages.${builtins.currentSystem};
in packages
