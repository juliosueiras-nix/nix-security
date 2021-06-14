# Modified from OpenJFX 11 drv
{ stdenv, lib, fetchurl, writeText, gradleGen, pkg-config, perl, cmake
, gperf, gtk2, gtk3, libXtst, libXxf86vm, glib, alsaLib, ffmpeg, python, ruby
, openjdk8-bootstrap }:

let
  major = "8";
  update = "u202";
  build = "ga";

  repover = "${major}${update}+${build}";
  gradleSpec = { version, nativeVersion, sha256 }: rec {
    inherit nativeVersion;
    name = "gradle-${version}";
    src = fetchurl {
      inherit sha256;
      url = "https://services.gradle.org/distributions/${name}-bin.zip";
    };
  };

  gradle_ = (gradleGen.override {
    java = openjdk8-bootstrap;
  }).gradleGen(gradleSpec {
    version = "4.8";
    nativeVersion = "0.14";
    sha256 = "8+KWkqj6qU6wsC6/NvomOmQrOuhpTvgGxFw0W4aD8bo=";
  });

  makePackage = args: stdenv.mkDerivation ({
    version = "${major}${update}-${build}";

    patches = [
      ./fix-build-gradle.patch
      ./fix-buildsrc-build-gradle.patch
      ./fix-linux-gradle.patch
    ];

    preConfigure = ''
      sed -i 's;#include <sys/sysctl.h>;;g' modules/fxpackager/src/main/native/library/common/PosixPlatform.cpp
      sed -i 's;#include <xlocale.h>;;g' modules/media/src/main/native/gstreamer/3rd_party/glib/glib-2.56.1/glib/gstrfuncs.c
      sed -i 's;#include <xlocale.h>;;g' modules/web/src/main/native/Source/ThirdParty/libxslt/src/libxslt/xsltlocale.h
    '';

    src = fetchurl {
      url = "https://hg.openjdk.java.net/openjfx/8u-dev/rt/archive/8u202-ga.tar.gz";
      sha256 = "K7seWCdU8RBT9K7eAzUdexx1ZaPJcpHp2ZtynVzij6Q=";
    };

    buildInputs = [ gtk2 gtk3 libXtst libXxf86vm glib alsaLib ffmpeg ];
    nativeBuildInputs = [ gradle_ perl pkg-config cmake gperf python ruby ];

    dontUseCmakeConfigure = true;

    config = writeText "gradle.properties" (''
      CONF = Release
      JDK_HOME = ${openjdk8-bootstrap.home}
    '' + args.gradleProperties or "");

    #avoids errors about deprecation of GTypeDebugFlags, GTimeVal, etc.
    NIX_CFLAGS_COMPILE = [ "-DGLIB_DISABLE_DEPRECATION_WARNINGS" ];

    buildPhase = ''
      runHook preBuild
      export GRADLE_USER_HOME=$(mktemp -d)
      ln -s $config gradle.properties
      export NIX_CFLAGS_COMPILE="$(pkg-config --cflags glib-2.0) $NIX_CFLAGS_COMPILE"
      gradle --no-daemon $gradleFlags sdk
      runHook postBuild
    '';
  } // args);

  # Fake build to pre-download deps into fixed-output derivation.
  # We run nearly full build because I see no other way to download everything that's needed.
  # Anyone who knows a better way?
  deps = makePackage {
    pname = "openjfx-deps";

    # perl code mavenizes pathes (com.squareup.okio/okio/1.13.0/a9283170b7305c8d92d25aff02a6ab7e45d06cbe/okio-1.13.0.jar -> com/squareup/okio/okio/1.13.0/okio-1.13.0.jar)
    installPhase = ''
      find $GRADLE_USER_HOME -type f -regex '.*/modules.*\.\(jar\|pom\)' \
        | perl -pe 's#(.*/([^/]+)/([^/]+)/([^/]+)/[0-9a-f]{30,40}/([^/\s]+))$# ($x = $2) =~ tr|\.|/|; "install -Dm444 $1 \$out/$x/$3/$4/$5" #e' \
        | sh
      rm -rf $out/tmp
    '';

    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
    # Downloaded AWT jars differ by platform.
    outputHash = {
      i686-linux = lib.fakeSha256;
      x86_64-linux = "AJC0Q99fdRkz9NuThx4jLZlj298R8hiVwsgJZubbdi0=";
    }.${stdenv.system} or (throw "Unsupported platform");
  };

in makePackage {
  pname = "openjfx-modular-sdk";

  gradleProperties = ''
    COMPILE_MEDIA = true
    COMPILE_WEBKIT = true
  '';

  preBuild = ''
    swtJar="$(find ${deps} -name org.eclipse.swt\*.jar)"
    substituteInPlace build.gradle \
      --replace 'mavenCentral()' 'mavenLocal(); maven { url uri("${deps}") }' \
      --replace 'name: SWT_FILE_NAME' "files('$swtJar')"
  '';

  installPhase = ''
    cp -r build/*sdk $out
  '';

  # glib-2.62 deprecations
  NIX_CFLAGS_COMPILE = "-DGLIB_DISABLE_DEPRECATION_WARNINGS";

  stripDebugList = [ "." ];

  postFixup = ''
    # Remove references to bootstrap.
    find "$out" -name \*.so | while read lib; do
      new_refs="$(patchelf --print-rpath "$lib" | sed -E 's,:?${openjdk8-bootstrap}[^:]*,,')"
      patchelf --set-rpath "$new_refs" "$lib"
    done
  '';

  disallowedReferences = [ openjdk8-bootstrap ];

  passthru.deps = deps;

  meta = with lib; {
    homepage = "http://openjdk.java.net/projects/openjfx/";
    license = licenses.gpl2;
    description = "The next-generation Java client toolkit";
    maintainers = with maintainers; [ abbradar juliosueiras ];
    platforms = [ "i686-linux" "x86_64-linux" ];
  };
}

