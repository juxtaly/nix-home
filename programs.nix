{
  config,
  lib,
  pkgs,
  ...
}: let
  packages = with pkgs; [
    # Modern Command Line Tools
    ripgrep # grep
    fd # find
    httpie # curl
    entr # Run arbitrary commands when files change
    dogdns # dig
    duf # df
    du-dust # du
    # pgcli
    tldr # man
    sd # sed
    difftastic # diff
    # plocate   # locate
    # nnn
    mtr # traceroute
    hyperfine # benchmarking
    croc # scp
    choose # cut awk
    lnav # browse log files

    fortune
    gum # interactive shell script
    glow # markdown
    lynx # web
    sqlite
    unzip
    cloc
    nb
    w3m
    nmap
  ];
  program_list = [
    "git"
    "starship"
    "exa" # ls
    "bat" # cat
    "fzf"
    "mcfly"
    "direnv"
    "zellij" # tmux
    "btop" # htop
    "broot" # tree
    "jq"
    "lazygit"
    "pandoc"
    "zoxide" # z
  ];
  configs = {
    git.delta.enable = true;
    exa.enableAliases = true;
    bat.config = {theme = "TwoDark";};
    fzf.defaultCommand = "rg --files --hidden --glob '!.git'";
    fzf.defaultOptions = ["--height=40%" "--layout=reverse" "--border" "--margin=1" "--padding=1"];
    mcfly.keyScheme = "vim";
    direnv.nix-direnv.enable = true;
    zellij.settings = {
      pane_frames = false;
      default_mode = "locked";
      default_layout = "compact";
    };
  };
in {
  home.packages = packages;
  programs = lib.recursiveUpdate (lib.genAttrs program_list (_: {enable = true;})) configs;
}
