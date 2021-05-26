{
  description = "Nix Security Tools Collection";

  inputs.nixpkgs.url =
    "github:nixos/nixpkgs/master";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
      in {
        packages = pkgs.callPackage ./pkgs/top-level.nix {};

        devShell =
          pkgs.mkShell { 
            NIX_PATH = "nixpkgs=${nixpkgs}";
            buildInputs = [ 
              pkgs.nix-prefetch-git
              pkgs.nixfmt
              pkgs.arion
              pkgs.gdb
              pkgs.ripgrep
              self.packages.x86_64-linux.wifi-80211.freeradius-wpe
            ];
          };
      });
}
