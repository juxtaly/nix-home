return function (use)
  use({
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly',
    config = function ()
      local nt = require('nvim-tree')
      local api = require('nvim-tree.api')
      nt.setup({
      })
      vim.keymap.set('n', '<leader>f', function ()
        api.tree.toggle({
          find_file = true,
        })
      end, { silent = true, desc = 'Toggle NvimTree' })
      vim.api.nvim_create_autocmd({"QuitPre"}, {
        callback = api.tree.close,
      })
    end,
  })
end
