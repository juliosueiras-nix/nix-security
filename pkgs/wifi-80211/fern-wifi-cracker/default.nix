{ stdenv, qt5, python3, python3Packages, makeWrapper, lib, fetchFromGitHub }:

let
  version = "3.3";
in stdenv.mkDerivation rec {
  pname = "fern-wifi-cracker"; inherit version;

  buildInputs = [ qt5.wrapQtAppsHook python3Packages.wrapPython makeWrapper ];

  patches = [
    ./resource_path.patch
  ];

  installPhase = ''
    mkdir -p $out/share/fern-wifi-cracker
    cp -rf Fern-Wifi-Cracker/* $out/share/fern-wifi-cracker

    wrapPythonPrograms

    makeWrapper "${python3.withPackages(p: [ p.pyqt5 p.scapy ])}/bin/python" $out/bin/fern-wifi-cracker --add-flags "$out/share/fern-wifi-cracker/execute.py" --set QT_PLUGIN_PATH "${qt5.qtbase}/${qt5.qtbase.qtPluginPrefix}" --set RESOURCE_PATH $out/share/fern-wifi-cracker
  '';

  src = fetchFromGitHub {
    owner = "savio-code";
    repo = "fern-wifi-cracker";
    rev = "v${version}";
    sha256 = "zJ1NSSipWj5rk6r7DtQRvtcp2MI0Np4NmjLLERZIAr0=";
  };
}

