# This file defines a function that takes a single optional argument 'pkgs'
# If pkgs is not set, it defaults to importing the nixpkgs found in NIX_PATH


{ pkgs ? import <nixpkgs> {} }:
let
   # Convenience alias for the standard environment
   stdenv = pkgs.stdenv;
in rec {

  php = pkgs.php54 {};

  # Defines our application package
  cgiapp = stdenv.mkDerivation {
    name = "cgirest";
    # The source code is stored in our 'app' directory
    src = ./cgirest;
    # Our package depends on the php package
    buildInputs = [ pkgs.php ];

    # Our application has no ./configure script nor Makefile, installing simply involves
    # copying files from the source directory (set as cwd) to the designated output directory ($out).
    installPhase = ''
      mkdir -p $out
      cp -r * $out/
    '';
  };
}
