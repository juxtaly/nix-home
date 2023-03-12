{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.neovim = let
    neovimPrivateDir = ./nvim;
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
