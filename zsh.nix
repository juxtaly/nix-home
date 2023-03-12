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
in {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      cat = "bat";
    };
    initExtra = builtins.readFile ./zsh/zshrc;
    envExtra = builtins.readFile ./zsh/zshenv;
    plugins = with pkgs; [
      {
        name = "z";
        src = fetchFromGitHub {
          owner = "rupa";
          repo = "z";
          rev = "v1.11";
          sha256 = "sha256-y8N3ug3QSVhU5REJMRM6WXYpSVs4zyuL3RADb+R8648=";
        };
        file = "z.sh";
      }
      {
        name = "ohmyzsh/colored-man-pages";
        src = "${omz}/plugins/colored-man-pages";
        file = "colored-man-pages.plugin.zsh";
      }
      {
        name = "ohmyzsh/command-not-found";
        src = "${omz}/plugins/command-not-found";
        file = "command-not-found.plugin.zsh";
      }
      {
        name = "ohmyzsh/git";
        src = "${omz}/plugins/git";
        file = "git.plugin.zsh";
      }
      {
        name = "ohmyzsh/git-extras";
        src = "${omz}/plugins/git-extras";
        file = "git-extras.plugin.zsh";
      }
    ];
  };
}
