-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false
vim.o.guifont = "Rec Mono Casual,Fira Code Nerd Font:h18"
if vim.g.neovide then
  vim.keymap.set({ "n", "v", "i" }, "<M-enter>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Toggle neovide fullscreen", silent = true })
end
