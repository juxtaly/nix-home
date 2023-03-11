return function (use)
  use({
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly',
    config = function()
      require('nvim-tree').setup({
        -- see :help nvim-tree-setup
      })
      vim.keymap.set('n', '<leader>f', require('nvim-tree').toggle, { desc = 'Toggle NvimTree' })
    end
  })
end
