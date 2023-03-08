local function plugins(use)

  -- which-key.nvim -- 💥 Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
  use({
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({
      --   plugins = {
      --     marks = true, -- shows a list of your marks on ' and `
      --     registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      --     spelling = {
      --       enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      --       suggestions = 20, -- how many suggestions should be shown in the list?
      --     },
      --     -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      --     -- No actual key bindings are created
      --     presets = {
      --       operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      --       motions = true, -- adds help for motions
      --       text_objects = true, -- help for text objects triggered after entering an operator
      --       windows = true, -- default bindings on <c-w>
      --       nav = true, -- misc bindings to work with windows
      --       z = true, -- bindings for folds, spelling and others prefixed with z
      --       g = true, -- bindings for prefixed with g
      --     },
      --   },
      --   -- add operators that will trigger motion and text object completion
      --   -- to enable all native operators, set the preset / operators plugin above
      --   operators = { gc = "Comments" },
      --   key_labels = {
      --     -- override the label used to display some keys. It doesn't effect WK in any other way.
      --     -- For example:
      --     -- ["<space>"] = "SPC",
      --     -- ["<cr>"] = "RET",
      --     -- ["<tab>"] = "TAB",
      --   },
      --   icons = {
      --     breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      --     separator = "➜", -- symbol used between a key and it's label
      --     group = "+", -- symbol prepended to a group
      --   },
      --   popup_mappings = {
      --     scroll_down = '<c-d>', -- binding to scroll down inside the popup
      --     scroll_up = '<c-u>', -- binding to scroll up inside the popup
      --   },
      --   window = {
      --     border = "none", -- none, single, double, shadow
      --     position = "bottom", -- bottom, top
      --     margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      --     padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      --     winblend = 0
      --   },
      --   layout = {
      --     height = { min = 4, max = 25 }, -- min and max height of the columns
      --     width = { min = 20, max = 50 }, -- min and max width of the columns
      --     spacing = 3, -- spacing between columns
      --     align = "left", -- align columns left, center or right
      --   },
      --   ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      --   hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
      --   show_help = true, -- show help message on the command line when the popup is visible
      --   show_keys = true, -- show the currently pressed key and its label as a message in the command line
      --   triggers = "auto", -- automatically setup triggers
      --   -- triggers = {"<leader>"} -- or specify a list manually
      --   triggers_blacklist = {
      --     -- list of mode / prefixes that should never be hooked by WhichKey
      --     -- this is mostly relevant for key maps that start with a native binding
      --     -- most people should not need to change this
      --     i = { "j", "k" },
      --     v = { "j", "k" },
      --   },
      --   -- disable the WhichKey popup for certain buf types and file types.
      --   -- Disabled by deafult for Telescope
      --   disable = {
      --     buftypes = {},
      --     filetypes = { "TelescopePrompt" },
      --   },
      })
    end
  })

  -- leap.nvim -- 🦘 Neovim's answer to the mouse
  use({
    'ggandor/leap.nvim',
    requires = { 'tpope/vim-repeat' },
    config = function()
      require('leap').add_default_mappings(true)
      -- see :help leap-config
    end
  })

  -- nvim-tree.lua -- A file explorer tree for neovim written in lua
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

  -- neoscroll.nvim -- Smooth scrolling neovim plugin written in lua
  use({
    'karb94/neoscroll.nvim',
    config = function ()
      -- require('neoscroll').setup({
      --   -- All these keys will be mapped to their corresponding default scrolling animation
      --   mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
      --     '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
      --   hide_cursor = true,          -- Hide cursor while scrolling
      --   stop_eof = true,             -- Stop at <EOF> when scrolling downwards
      --   respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      --   cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      --   easing_function = nil,       -- Default easing function
      --   pre_hook = nil,              -- Function to run before the scrolling animation starts
      --   post_hook = nil,             -- Function to run after the scrolling animation ends
      --   performance_mode = false,    -- Disable "Performance Mode" on all buffers.
      -- })
    end
  })

  -- dressing.nvim -- Neovim plugin to improve the default vim.ui interfaces
  use({
    'stevearc/dressing.nvim',
    config = function ()
      require('dressing').setup({
        -- see :help dressing-configuration
      })
    end
  })

  -- marks.nvim -- A better user experience for viewing and interacting with Vim marks.
  use({
    'chentoast/marks.nvim',
    config = function ()
      require('marks').setup({
        --   -- whether to map keybinds or not. default true
        --   default_mappings = true,
        --   -- which builtin marks to show. default {}
        --   builtin_marks = { ".", "<", ">", "^" },
        --   -- whether movements cycle back to the beginning/end of buffer. default true
        --   cyclic = true,
        --   -- whether the shada file is updated after modifying uppercase marks. default false
        --   force_write_shada = false,
        --   -- how often (in ms) to redraw signs/recompute mark positions. 
        --   -- higher values will have better performance but may cause visual lag, 
        --   -- while lower values may cause performance penalties. default 150.
        --   refresh_interval = 250,
        --   -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        --   -- marks, and bookmarks.
        --   -- can be either a table with all/none of the keys, or a single number, in which case
        --   -- the priority applies to all marks.
        --   -- default 10.
        --   sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        --   -- disables mark tracking for specific filetypes. default {}
        --   excluded_filetypes = {},
        --   -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        --   -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        --   -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        --   -- default virt_text is "".
        --   bookmark_0 = {
        --     sign = "⚑",
        --     virt_text = "hello world",
        --     -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
        --     -- defaults to false.
        --     annotate = false,
        --   },
        --   mappings = {}
      })
    end
  })

  -- toggleterm.nvim -- A neovim lua plugin to help easily manage multiple terminal windows
  use({
    'akinsho/toggleterm.nvim',
    config = function ()
      require('toggleterm').setup({
        open_mapping = [[<leader>t]],
        insert_mappings = false
      })
    end
  })

  use 'ThePrimeagen/vim-be-good'

  -- trouble.nvim -- 🚦 A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  use({
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }

      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        {silent = true, noremap = true}
      )
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        {silent = true, noremap = true}
      )
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
        {silent = true, noremap = true}
      )
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
        {silent = true, noremap = true}
      )
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        {silent = true, noremap = true}
      )
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
        {silent = true, noremap = true}
      )
    end
  })

  -- noice.nvim -- 💥 Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  use({
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options here
        lsp = {

          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
      })

      vim.keymap.set({"n", "i", "s"}, "<c-f>", function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end, { silent = true, expr = true })

      vim.keymap.set({"n", "i", "s"}, "<c-b>", function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end, { silent = true, expr = true })
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  })

  -- zen-mode.nvim -- 🧘 Distraction-free coding for Neovim
  use({
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  })

  -- TODO: default mapping conflict with leap.nvim, consider change default mappings of leap.nvim
  -- nvim-surround -- Add/change/delete surrounding delimiter pairs with ease. Written with ❤️ in Lua.
  -- use({
  --   "kylechui/nvim-surround",
  --   tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  --   config = function()
  --     require("nvim-surround").setup({
  --       -- Configuration here, or leave empty to use defaults
  --     })
  --   end
  -- })

  -- competitest.nvim -- CompetiTest.nvim is a Neovim plugin to automate testcases management and checking for Competitive Programming
  use({
    'xeluxee/competitest.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = function()
      require('competitest').setup()
    end
  })

  -- aerial.nvim -- Neovim plugin for a code outline window
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

  -- overseer.nvim -- A task runner and job management plugin for Neovim
  use({
    'stevearc/overseer.nvim',
    config = function ()
      require('overseer').setup()
    end
  })

  -- haskell-tools.nvim -- Supercharge your Haskell experience in neovim! 
  use({
    'mrcjkb/haskell-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- optional
    },
    branch = '1.x.x', -- recommended
  })

end

local function _plugins(use)
  use 'ThePrimeagen/vim-be-good'
end

return plugins
