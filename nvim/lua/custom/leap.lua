return function (use)
  use({
    'ggandor/leap.nvim',
    requires = { 'tpope/vim-repeat' },
    config = function()
      require('leap').add_default_mappings(true)
      -- see :help leap-config
    end
  })
end
