local ok, cmp = pcall(require, 'cmp')
if not ok then
  return
end

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local function cmp_set_hl(hl_groups, fg)
  local first = hl_groups[1]
  for i, hl_group in ipairs(hl_groups) do
    if i == 1 then
      vim.api.nvim_set_hl(0, hl_group, {
        bg = 'NONE',
        fg = fg,
      })
    else
      vim.api.nvim_set_hl(0, hl_group, {
        link = first
      })
    end
  end
end

-- " gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', {
  strikethrough = true,
  bg = 'NONE',
  fg = '#808080'
})
-- " blue
cmp_set_hl({'CmpItemAbbrMatch', 'CmpItemAbbrMatchFuzzy'}, '#569CD6')
-- " light blue
cmp_set_hl({'CmpItemKindVariable', 'CmpItemKindInterface', 'CmpItemKindText'}, '#9CDCFE')
-- " pink
cmp_set_hl({'CmpItemKindFunction', 'CmpItemKindMethod'}, '#C586C0')
-- " front
cmp_set_hl({'CmpItemKindKeyword', 'CmpItemKindProperty', 'CmpItemKindUnit'}, '#D4D4D4')

local has_luasnip, luasnip = pcall(require, 'luasnip')

local expand_snippet = function(args)
  if has_luasnip then
    luasnip.lsp_expand(args.body)
  end
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local super_tab = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif has_luasnip and luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

local super_stab = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif has_luasnip and luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

cmp.setup {
  snippet = {
    expand = expand_snippet,
  },
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(super_tab, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(super_stab, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer', keyword_length = 5 },
  }),
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}
