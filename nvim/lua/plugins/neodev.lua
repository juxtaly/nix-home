local ok, neodev = pcall(require, 'neodev')
if not ok then
  return
end

-- Setup neovim lua configuration
neodev.setup({
  library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
})
