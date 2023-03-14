{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.neovim = let
    /* neovimPrivateDir = ./support/nvim; */
    neovimPrivateDir = ./support/lazyvim;
  in {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    extraLuaConfig = ''
      vim.opt.runtimepath:append('${neovimPrivateDir}')
    '' + builtins.readFile "${neovimPrivateDir}/init.lua";
  };
}
