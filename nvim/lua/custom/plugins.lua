return function(use)
  use({
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({})
    end
  })

  use({
    'ggandor/leap.nvim',
    requires = { 'tpope/vim-repeat' },
    config = function()
      require('leap').add_default_mappings(true)
    end
  })

  use({
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly',
    config = function()
      require('nvim-tree').setup()
      vim.keymap.set('n', '<leader>f', require('nvim-tree').toggle, { desc = 'Toggle NvimTree' })
    end
  })
end
