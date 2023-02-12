vim.opt.relativenumber = false
vim.opt.cursorline = true

vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
