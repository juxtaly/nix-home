{ config, lib, pkgs, ... }:

{
  imports = [
    ./user.nix
    ./zsh.nix 
    ./programs.nix
  ];
  home.stateVersion = "22.05";
  home.sessionVariables = {
    EDITOR = "hx";
    COLORTERM = "truecolor";
    NIX_PATH = "$HOME/.nix-defexpr/channels:$NIX_PATH";
  };
  home.shellAliases = {
    hm = "home-manager";
  };
  xdg.configFile.nix = {
    source = ./nix;
    recursive = true;
  };
  programs.home-manager.enable = true;
}
