local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

-- Set lualine as statusline
-- See `:help lualine.txt`
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
  extensions = { 'aerial', 'nvim-tree', 'quickfix', 'toggleterm' },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true,
        newfile_status = true,
        path = 3,
        shorting_target = 40,
      }
    },
  },
}
