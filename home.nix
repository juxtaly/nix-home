{ config, lib, pkgs, ... }:

{
  imports = [ ./vim.nix ./zsh.nix ];
  home.packages = with pkgs; [
    ripgrep
  ];
  home.sessionVariables = {
    EDITOR = "vim";
    NIX_PATH = "$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels:$NIX_PATH";
  };
  home.shellAliases = {
    hm = "home-manager";
  };
  programs.home-manager.enable = true;
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "screen-256color";
  };
  programs.git = {
    enable = true;
  };
  programs.starship = {
    enable = true;
  };
  programs.exa = {
    enable = true;
    enableAliases = true;
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };
  programs.fzf = {
    enable = true;
    defaultCommand = "rg --files --hidden --glob '!.git'";
    defaultOptions = ["--height=40%" "--layout=reverse" "--border" "--margin=1" "--padding=1"];
  };
  programs.mcfly = {
    enable = true;
    keyScheme = "vim";
  };
}
