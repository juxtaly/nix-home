{ config, lib, pkgs, ... }:

let
  py-pkgs = python3Packages: with python3Packages; [
    pyqt5 sip
    pyqtwebengine
    epc lxml
    pysocks
  ];
  python-with-pkgs = pkgs.python310.withPackages py-pkgs;
in
{
  home.packages = with pkgs; [
   python-with-pkgs 
   nodejs wmctrl xdotool
  ];
  home.sessionVariables = {
    QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt5.qtbase.bin.outPath}/lib/qt-${pkgs.qt5.qtbase.version}/plugins";
    QT_XCB_GL_INTEGRATION = "none";
  };
  programs.aria2.enable = true;
  home.file.".emacs.d/site-lisp/emacs-application-framework".source = pkgs.callPackage ./eaf-drv.nix {};
}
