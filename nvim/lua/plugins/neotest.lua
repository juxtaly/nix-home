local ok, neotest = pcall(require, 'neotest')
if not ok then
  return
end

neotest.setup({
  adapters = {
    require("neotest-rust")
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = "x",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "P",
    running = "R",
    running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
    skipped = "S",
    unknown = "U"
  },
})

vim.keymap.set('n', '<F9>', function ()
  require('neotest').run.run(vim.fn.expand('%'))
end, { desc = 'Test: Run all tests in this file' })
vim.keymap.set('n', '<F10>', function ()
  require('neotest').summary.toggle()
end, { desc = 'Test: Toggle summary' })
