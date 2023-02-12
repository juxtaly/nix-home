{ config, lib, pkgs, ... }:

{
  imports = [
    ./user.nix
    ./zsh.nix 
    ./programs.nix
    ./nvim.nix
  ];
  home.stateVersion = "23.05";
  home.sessionVariables = {
    COLORTERM = "truecolor";
    NIX_PATH = "$HOME/.nix-defexpr/channels:$NIX_PATH";
  };
  home.shellAliases = {
    hm = "home-manager";
    lg = "lazygit";
  };
  xdg.configFile.nix = {
    source = ./nix;
    recursive = true;
  };
  programs.home-manager.enable = true;
}
