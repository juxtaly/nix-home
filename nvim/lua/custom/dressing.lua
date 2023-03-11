return function (use)
  use({
    'stevearc/dressing.nvim',
    config = function ()
      require('dressing').setup({
        -- see :help dressing-configuration
      })
    end
  })
end
