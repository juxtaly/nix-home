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
    nvim-packer-compile = "nvim --headless -c 'autocmd User PackerCompileDone quitall' -c 'PackerCompile'";
    nvim-packer-sync = "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'";
  };
  programs.home-manager.enable = true;
}
