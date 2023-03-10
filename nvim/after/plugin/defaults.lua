vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.o.guifont = "Rec Mono Casual,Fira Code Nerd Font:h18"
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0
-- vim.g.neovide_fullscreen = false
if vim.g.neovide then
  vim.keymap.set({'n', 'v', 'i'}, '<M-enter>', function ()
    vim.g.neovide_fullscreen = (not vim.g.neovide_fullscreen)
  end, { desc = 'Toggle neovide fullscreen', silent = true})
end

vim.keymap.set('n', '<leader><leader>r', function ()
  vim.cmd([[
    source $MYVIMRC
    runtime! plugin/**/*.vim
    runtime! plugin/**/*.lua
    runtime! after/**/*.vim
    runtime! after/**/*.lua
  ]])
end, { desc = 'Reload configs and plugins', silent = true})

-- ******************************
-- Toggleterm.nvim Configurations
-- :help toggleterm
-- ******************************
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local ok, terminal = pcall(require, 'toggleterm.terminal')
if ok then

  local Terminal  = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "double",
    },
    on_open = function (term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    on_close = function (term)
      vim.cmd("startinsert!")
    end
  })

  function _lazygit_toggle()
    lazygit:toggle()
  end

  vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { desc = 'Toggle Lazygit', noremap = true, silent = true})
end

-- **********************************
-- Toggleterm.nvim Configurations end
-- **********************************
