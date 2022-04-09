{ config, pkgs, ... }:
let
  alpha-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "alpha-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "goolord";
      repo = "alpha-nvim";
      rev = "665522838e5a5511ec888840b76bc7b9929ee115";
      sha256 = "sha256-/30QELLnb6wM9Iinp4Vykdx4wd1ZGHYdQoRR00vhCHA=";
    };
  }; in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      popup-nvim
      plenary-nvim
      nvim-autopairs
      comment-nvim
      nvim-web-devicons
      nvim-tree-lua
      bufferline-nvim
      vim-bbye
      lualine-nvim
      toggleterm-nvim
      project-nvim
      impatient-nvim
      indent-blankline-nvim
      alpha-nvim
      FixCursorHold-nvim
      which-key-nvim
      onedark-nvim
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip
      cmp-nvim-lsp
      luasnip
      friendly-snippets
      nvim-lspconfig
      null-ls-nvim
      telescope-nvim
      nvim-treesitter
      nvim-ts-context-commentstring
      gitsigns-nvim
      vim-nix
    ];
    extraConfig = ''
      luafile ${config.xdg.configHome}/nvim/init_lua.lua
    '';
  };
  xdg.configFile = {
    nvim = {
      source = ./nvim;
      recursive = true;
    };
  };
}
