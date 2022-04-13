{ config, pkgs, ... }:
let
  nlsp-settings = pkgs.vimUtils.buildVimPlugin {
    name = "nlsp-settings";
    src = pkgs.fetchFromGitHub {
      owner = "tamago324";
      repo = "nlsp-settings.nvim";
      rev = "99c94fa2bfd73adf14e5e7b1ebcf16611de87ae7";
      sha256 = "sha256-2Ui0fqLJw6YIw9LeDQxut3+nMLQxAMbtC3hvCJuAP3Q=";
    };
    dontBuild = true;
  };
  nvim-lsp-installer = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-lsp-installer";
    src = pkgs.fetchFromGitHub {
      owner = "williamboman";
      repo = "nvim-lsp-installer";
      rev = "ee082883d18a8990cec359862db4e93ea850cb8c";
      sha256 = "sha256-HVH5UHgWyR/QDTZ5OQ2G0YaUpSxONLQH7Y8zqMlb/+E=";
    };
    dontBuild = true;
  };
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
      # Dependencies
      popup-nvim
      plenary-nvim

      # Custom
      toggleterm-nvim
      project-nvim
      impatient-nvim

      # Languages
      vim-nix

      # UI
      lualine-nvim
      bufferline-nvim
      vim-bbye
      alpha-nvim
      which-key-nvim

      # Editing
      nvim-autopairs
      comment-nvim
      indent-blankline-nvim

      # File Explorer
      nvim-web-devicons
      nvim-tree-lua

      # Colorschemes
      onedark-nvim

      # Completion
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip
      cmp-nvim-lsp

      # Snippets
      luasnip
      friendly-snippets

      # LSP
      nvim-lspconfig
      nvim-lsp-installer
      nlsp-settings
      null-ls-nvim
      FixCursorHold-nvim

      # Telescope
      telescope-nvim

      # Treesitter
      nvim-treesitter
      nvim-ts-context-commentstring

      # Git
      gitsigns-nvim
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
