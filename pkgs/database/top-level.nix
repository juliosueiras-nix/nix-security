{ callPackage, pkgs, ... }:

{
  inherit (pkgs) mdbtools sqlitebrowser sqlmap;
  jsql-injection = callPackage ./jsql-injection { };
  oscanner = callPackage ./oscanner { };
  sidguesser = callPackage ./sidguesser { };
  sqldict = callPackage ./sqldict { };
  sqlninja = callPackage ./sqlninja { };
  sqlsus = callPackage ./sqlsus { };
  tnscmd10g = callPackage ./tnscmd10g { };
}
