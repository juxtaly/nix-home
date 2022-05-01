{ version ? "dev", config, lib, pkgs, stdenv, ... }:

let
  eaf = pkgs.fetchFromGitHub {
    owner = "emacs-eaf";
    repo = "emacs-application-framework";
    rev = "98ebfb9f2bd24950adf2988f59b17a822b69f202";
    sha256 = "sha256-ufedZX2uD3Or9Z4e1pVrG1rQ0VzsTjSLfq3Igu+Zlcs=";
  };
  eaf-demo = pkgs.fetchFromGitHub {
    owner = "emacs-eaf";
    repo = "eaf-demo";
    rev = "b8eafe9fc72fa857364f1dee10e5c4539ef58c7f";
    sha256 = "sha256-leVgH7ABWNvQUBeLfWKUEMsHPwBWWHsX0pbEdI4ftN4=";
  };
  eaf-pdf-viewer = pkgs.fetchFromGitHub {
    owner = "emacs-eaf";
    repo = "eaf-pdf-viewer";
    rev = "ce363fb928873827d2065b4598f1d86290f27cc5";
    sha256 = "sha256-51TUPotl2VpOst6R+tdbWiSYgg13uGdFBJzjRZ+NMwg=";
  };
  eaf-browser = (pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "atriw";
    repo = "eaf-browser";
    rev = "v0.0.1";
    sha256 = "sha256-blp3nPfSeAuK5nUl1A/MflzEIHqDwpjM3yFlSXlFavY=";
  }) {}).package;
in
stdenv.mkDerivation {
  pname = "emacs-application-framework";
  inherit version;
  src = eaf;
  buildInputs = [eaf-browser eaf-pdf-viewer eaf-demo];
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/
    cp -r $src/* $out/
    mkdir -p $out/app/eaf-browser
    cp -r ${eaf-browser}/lib/node_modules/eaf-browser/* $out/app/eaf-browser/
    mkdir -p $out/app/eaf-pdf-viewer
    cp -r ${eaf-pdf-viewer}/* $out/app/eaf-pdf-viewer
    mkdir -p $out/app/eaf-demo
    cp -r ${eaf-demo}/* $out/app/eaf-demo/
  '';
}
