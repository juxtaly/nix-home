return function (use)
  use({
    'stevearc/aerial.nvim',
    config = function ()
      require('aerial').setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '[a', '<cmd>AerialPrev<CR>', {buffer = bufnr})
          vim.keymap.set('n', ']a', '<cmd>AerialNext<CR>', {buffer = bufnr})
        end
      })
      vim.keymap.set('n', '<leader>v', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial', silent = true })
    end
  })
end
