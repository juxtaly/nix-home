{
  config,
  lib,
  pkgs,
  ...
}: let
  omz = pkgs.fetchFromGitHub {
    owner = "ohmyzsh";
    repo = "ohmyzsh";
    rev = "fcceeb666452c5a41b786f3cde9c8635ddde5448";
    sha256 = "sha256-c929KV77wACO0AlEABwOPPz03Za8V4G7RRXalY+zfGg=";
  };
  plugins = [
    "colored-man-pages"
    "command-not-found"
    "git"
    "git-extras"
  ];
in {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    initExtra = builtins.readFile ./support/zsh/zshrc;
    envExtra = builtins.readFile ./support/zsh/zshenv;
    plugins = builtins.map (p: {
      name = "ohmyzsh/${p}";
      src = "${omz}/plugins/${p}";
      file = "${p}.plugin.zsh";
    }) plugins;
  };
}
