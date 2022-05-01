{ version ? "dev", config, lib, pkgs, stdenv, ... }:

let
  # eaf-browser = builtins.fetchTarball {
  #   url = https://github.com/emacs-eaf/eaf-browser/archive/master.tar.gz;
  # };
  # eaf-demo = builtins.fetchTarball {
  #   url = https://github.com/emacs-eaf/eaf-demo/archive/master.tar.gz;
  # };
  # eaf = builtins.fetchTarball {
  #   url = https://github.com/emacs-eaf/emacs-application-framework/archive/master.tar.gz;
  # };
  eaf = pkgs.fetchFromGitHub {
    owner = "emacs-eaf";
    repo = "emacs-application-framework";
    rev = "98ebfb9f2bd24950adf2988f59b17a822b69f202";
    sha256 = "sha256-ufedZX2uD3Or9Z4e1pVrG1rQ0VzsTjSLfq3Igu+Zlcs=";
  };
  #eaf-browser-node-modules = (pkgs.callPackage ../eaf-browser/default.nix {}).nodeDependencies;
  # eaf-browser = stdenv.mkDerivation {
  #   pname = "eaf-browser";
  #   inherit version;
  #   src = ../eaf-browser;
  #   # src = pkgs.fetchFromGitHub {
  #   #   owner = "emacs-eaf";
  #   #   repo = "eaf-browser";
  #   #   rev = "89e3deea7e32a2e83911ff11e12cc3fc2949d9fb";
  #   #   sha256 = "sha256-7DpAq5QpK4ZQCQk6AwgBRe8Q0I8i9MyTLk2MJVVGPSg=";
  #   # };
  #   dontBuild = true;
  #   installPhase = ''
  #     mkdir -p $out/
  #     cp -r $src/* $out/
  #     cp -r ./* $out/
  #   '';
  # };
  eaf-browser = ../eaf-browser;
  eaf-demo = pkgs.fetchFromGitHub {
    owner = "emacs-eaf";
    repo = "eaf-demo";
    rev = "b8eafe9fc72fa857364f1dee10e5c4539ef58c7f";
    sha256 = "sha256-leVgH7ABWNvQUBeLfWKUEMsHPwBWWHsX0pbEdI4ftN4=";
  };
in
stdenv.mkDerivation {
  pname = "emacs-application-framework";
  inherit version;
  src = eaf;
  buildInputs = [eaf-browser eaf-demo];
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/
    cp -r $src/* $out/
    mkdir -p $out/app/eaf-browser
    cp -r ${eaf-browser}/* $out/app/eaf-browser/
    mkdir -p $out/app/eaf-demo
    cp -r ${eaf-demo}/* $out/app/eaf-demo/
  '';
}
