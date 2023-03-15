{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./zsh.nix
    ./programs.nix
    ./nvim.nix
  ];
  home.username = "matrix";
  home.homeDirectory = "/home/matrix";
  home.stateVersion = "23.05";
  home.sessionVariables = {
    COLORTERM = "truecolor";
    NIX_PATH = "$HOME/.nix-defexpr/channels:$NIX_PATH";
  };
  home.shellAliases = {
    hm = "home-manager";
    lg = "lazygit";
    cat = "bat";
  };
  programs.home-manager.enable = true;
}
