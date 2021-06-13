{ fetchMavenArtifact, sleuthkit, jdk8, ant, ... }:

let
  joda-time = fetchMavenArtifact {
    groupId = "joda-time";
    artifactId = "joda-time";
    version = "2.4";
    sha256 = "qWSpgneUru9xEUfh7kC0yr6czn/xSfGsm7nuTlyuUaw=";
  };
  ivy = fetchMavenArtifact {
    groupId = "org.apache.ivy";
    artifactId = "ivy";
    version = "2.5.0";
    sha256 = "L0yDW1IxHfki+KjrBXhD3lSFCIsjTM0D5Hi5Bmtea/w=";
  }; 
  guava = fetchMavenArtifact {
    groupId = "com.google.guava";
    artifactId = "guava";
    version = "19.0";
    sha256 = "WNTMLgXrsBK7rFaLAy91Yjvhy2+wlvPGDHKob38FfeQ=";
  };
  commons-lang3 = fetchMavenArtifact {
    groupId = "org.apache.commons";
    artifactId = "commons-lang3";
    version = "3.0";
    sha256 = "mA7xTLBGjHCA+Ipy+rc/nInAKSF/PIxTWwZyVw4yzAg=";
  };
  commons-validator = fetchMavenArtifact {
    groupId = "commons-validator";
    artifactId = "commons-validator";
    version = "1.6";
    sha256 = "vWJ5XXBoppy+ozP22/nJwaatdSFEP7VyAqRIdPJAuiU=";
  };
  gson = fetchMavenArtifact {
    groupId = "com.google.code.gson";
    artifactId = "gson";
    version = "2.8.5";
    sha256 = "IzoBSfw2XJ9u29aDz+JmsZvcdzvpjqva9rPJJLSOfYE=";
  };
  junit = fetchMavenArtifact {
    groupId = "junit";
    artifactId = "junit";
    version = "4.8.2";
    sha256 = "oqosO7K3LadsPmpxUx8e79w1BJSBm68rHYDXFG4CD54=";
  };

  diffutils = fetchMavenArtifact {
    groupId = "com.googlecode.java-diff-utils";
    artifactId = "diffutils";
    version = "1.2.1";
    sha256 = "yYaXw7jddFNTzQqDsQnByZn+xDtKXO2y9XlFLY2iwXE=";
  };

  sqlite-jdbc = fetchMavenArtifact {
    groupId = "org.xerial";
    artifactId = "sqlite-jdbc";
    version = "3.25.2";
    sha256 = "pF2mGr7WFWilM/3s4SUJMYCCjt6w1Lb21XLgz0V0ZfY=";
  };

  c3p0 = fetchMavenArtifact {
    groupId = "com.mchange";
    artifactId = "c3p0";
    version = "0.9.5";
    sha256 = "jd6e07Z5+ySLA08bdGwuNOKVEnwvZQPhf3VH9E4FTz8=";
  };

  commons-java = fetchMavenArtifact {
    groupId = "com.mchange";
    artifactId = "mchange-commons-java";
    version = "0.2.9";
    sha256 = "SyPYMvplMRZgDqeXEGtLNnhU9qlJTpq97I8Uji2mOR0=";
  };

  sparse-bit = fetchMavenArtifact {
    groupId = "com.zaxxer";
    artifactId = "SparseBitSet";
    version = "1.1";
    sha256 = "PzXTdtm8T3Bf82L4uJEl1Y3NLnvUmLh6orks+1aU7Y4=";
  };

  postgresql-java = fetchMavenArtifact {
    groupId = "org.postgresql";
    artifactId = "postgresql";
    version = "42.2.18";
    sha256 = "DIkZefHrL+REMtoRTQl2C1Bj2tnmaawKxrC2v7kbs7o=";
  };
in sleuthkit.overrideAttrs(old:{

  configureFlags = ["--enable-java" "--enable-offline"];
  buildInputs = old.buildInputs ++ [ jdk8 ant ];

  prePatch = ''
    export HOME=$TMP
    export ANT_HOME=$HOME/.ant
    export IVY_HOME=$HOME/.ivy
    mkdir -p $IVY_HOME/lib
    mkdir -p $HOME/.java/lib
    mkdir -p case-uco/java/lib
    sed -i "s;/usr/share/java;$HOME/.java/lib;g" bindings/java/build.xml
    sed -i "s;$(prefix)/share/java;$HOME/.java/lib;g" case-uco/java/Makefile.am
    
    cp ${joda-time}/share/java/*.jar $HOME/.java/lib
    cp ${guava}/share/java/*.jar $HOME/.java/lib
    cp ${commons-lang3}/share/java/*.jar $HOME/.java/lib
    cp ${commons-validator}/share/java/*.jar $HOME/.java/lib
    cp ${commons-java}/share/java/*.jar $HOME/.java/lib
    cp ${gson}/share/java/*.jar $HOME/.java/lib
    cp ${gson}/share/java/*.jar case-uco/java/lib/
    cp ${diffutils}/share/java/*.jar $HOME/.java/lib
    cp ${sqlite-jdbc}/share/java/*.jar $HOME/.java/lib
    cp ${sparse-bit}/share/java/*.jar $HOME/.java/lib
    cp ${c3p0}/share/java/*.jar $HOME/.java/lib
    cp ${junit}/share/java/*.jar $HOME/.java/lib
    cp ${postgresql-java}/share/java/*.jar $HOME/.java/lib
    cp ${ivy}/share/java/*.jar $IVY_HOME/lib/ivy.jar
  '';
})
