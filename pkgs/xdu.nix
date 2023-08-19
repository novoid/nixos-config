{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  pname = "xdu";
  version = "3.0";

  src = fetchFromGitHub {
    owner = "vlasovskikh";
    repo = "xdu";
    rev = "d62444a199eb7ec21605d8960a7261affc37d2b4";
    hash = "sha256-h6X2Gx0/MUjIpkcxcFGuIFCS/+UKcW2kJE9hm0NDGNU=";
  };

  nativeBuildInputs = with xorg; [
    imake
    gccmakedep
  ];

  buildInputs = with xorg; [
    libXt
    libXaw
    libXpm
    libXext
  ];

  configurePhase = ''
    xmkmf
  '';

  NIX_CFLAGS_COMPILE = [
    "-Wno-error=format-security"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp xdu $out/bin/xdu
  '';
}

