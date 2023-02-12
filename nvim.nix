{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    # extraLuaConfig = builtins.readFile ./kickstart.nvim/init.lua;
  };
  xdg.configFile = {
    nvim = {
      source = ./nvim;
      recursive = true;
    };
  };
}
