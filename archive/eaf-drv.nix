{ version ? "dev", config, lib, pkgs, stdenv, ... }:

let
  eaf = pkgs.fetchFromGitHub {
    owner = "emacs-eaf";
    repo = "emacs-application-framework";
    rev = "98ebfb9f2bd24950adf2988f59b17a822b69f202";
    sha256 = "sha256-ufedZX2uD3Or9Z4e1pVrG1rQ0VzsTjSLfq3Igu+Zlcs=";
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
  buildInputs = [eaf-browser];
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/
    cp -r $src/* $out/
    mkdir -p $out/app/eaf-browser
    cp -r ${eaf-browser}/lib/node_modules/eaf-browser/* $out/app/eaf-browser/
  '';
}
