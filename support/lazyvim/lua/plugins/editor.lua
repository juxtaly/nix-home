return {
  -- telescope-project.nvim
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-project.nvim",
      config = function()
        require("telescope").load_extension("project")
      end,
    },
    keys = {
      {
        "<leader>fp",
        "<cmd>Telescope project display_type=full<cr>",
        desc = "Find project",
      },
    },
  },
  -- symbols-outline.nvim -- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = function()
      local icons = require("lazyvim.config").icons
      require("symbols-outline").setup({
        symbols = {
          File = { icon = icons.kinds.File, hl = "TSURI" },
          Module = { icon = icons.kinds.Module, hl = "TSNamespace" },
          Namespace = { icon = icons.kinds.Namespace, hl = "TSNamespace" },
          Package = { icon = icons.kinds.Package, hl = "TSNamespace" },
          Class = { icon = icons.kinds.Class, hl = "TSType" },
          Method = { icon = icons.kinds.Method, hl = "TSMethod" },
          Property = { icon = icons.kinds.Property, hl = "TSMethod" },
          Field = { icon = icons.kinds.Field, hl = "TSField" },
          Constructor = { icon = icons.kinds.Constructor, hl = "TSConstructor" },
          Enum = { icon = icons.kinds.Enum, hl = "TSType" },
          Interface = { icon = icons.kinds.Interface, hl = "TSType" },
          Function = { icon = icons.kinds.Function, hl = "TSFunction" },
          Variable = { icon = icons.kinds.Variable, hl = "TSConstant" },
          Constant = { icon = icons.kinds.Constant, hl = "TSConstant" },
          String = { icon = icons.kinds.String, hl = "TSString" },
          Number = { icon = icons.kinds.Number, hl = "TSNumber" },
          Boolean = { icon = icons.kinds.Boolean, hl = "TSBoolean" },
          Array = { icon = icons.kinds.Array, hl = "TSConstant" },
          Object = { icon = icons.kinds.Object, hl = "TSType" },
          Key = { icon = icons.kinds.Key, hl = "TSType" },
          Null = { icon = icons.kinds.Null, hl = "TSType" },
          EnumMember = { icon = icons.kinds.EnumMember, hl = "TSField" },
          Struct = { icon = icons.kinds.Struct, hl = "TSType" },
          Event = { icon = icons.kinds.Event, hl = "TSType" },
          Operator = { icon = icons.kinds.Operator, hl = "TSOperator" },
          TypeParameter = { icon = icons.kinds.TypeParameter, hl = "TSParameter" },
        },
      })
    end,
  },
  -- zen-mode.nvim -- 🧘 Distraction-free coding for Neovim
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = true,
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
  -- marks.nvim -- A better user experience for viewing and interacting with Vim marks.
  {
    "chentoast/marks.nvim",
    config = true,
  },
  -- pretty-fold.nvim -- Foldtext customization in Neovim
  {
    "anuvyklack/pretty-fold.nvim",
    config = true,
  },
}
