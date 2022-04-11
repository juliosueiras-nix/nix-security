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
        packages = import ./pkgs/top-level.nix {
          callPackage = pkgs.callPackage;
          lib = pkgs.lib;
          pkgs = pkgs;
        };

        devShell =
          pkgs.mkShell { 
            NIX_PATH = "nixpkgs=${nixpkgs}";
            buildInputs = [ 
              pkgs.nix-prefetch-git
              pkgs.nixfmt
              pkgs.arion
              pkgs.gdb
              pkgs.ripgrep
              pkgs.nixUnstable
            ];
          };
      });
}
