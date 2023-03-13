{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.neovim = let
    neovimPrivateDir = ./support/nvim;
  in {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    extraLuaConfig = ''
      vim.opt.runtimepath:append('${neovimPrivateDir}')
      vim.opt.runtimepath:append('${neovimPrivateDir}/after')
      require('init')
    '';
  };
}
