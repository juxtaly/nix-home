{ config, lib, pkgs, ... }:

{
  imports = [
    ./vim.nix 
    ./zsh.nix 
    ./doom-emacs.nix 
    ./eaf.nix
    ./programs.nix
  ];
  home.sessionVariables = {
    EDITOR = "vim";
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
