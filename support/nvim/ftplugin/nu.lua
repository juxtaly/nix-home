local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
