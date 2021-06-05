{ stdenv, lib, makeWrapper, jre, fetchFromGitLab, ... }:

stdenv.mkDerivation {
  name = "oscanner";

  version = "1.0.6";

  src = fetchFromGitLab {
    repo = "oscanner";
    owner = "kalilinux/packages";
    rev = "e0249f3d9ab35a06d431ed4ddb97552e762b81fa";
    sha256 = "9qaDeOjnZWjJxzmtVJvWMH4q/ei5/gaW+SDhk6oPMZM=";
  };

  buildInputs = [
    makeWrapper
  ];

  installPhase = ''
        mkdir -p $out/{share,bin}
        cp -r * $out/share/
        CP=$(tr '\n' ':' <<EOF
    $(ls $out/share/*.jar)
    EOF
        )
        makeWrapper ${jre}/bin/java $out/bin/oscanner --add-flags "-cp .:$CP ork.OracleScanner" --run "cd $out/share"
  '';
}
