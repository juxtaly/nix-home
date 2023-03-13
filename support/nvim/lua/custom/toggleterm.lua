return function(use)
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<leader>t]],
				insert_mappings = false,
				terminal_mappings = false,
				shell = "nu",
			})
			local set_terminal_keymaps = function()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.api.nvim_create_autocmd({ "TermOpen" }, {
				pattern = { "term://*" },
				callback = set_terminal_keymaps,
			})

			if pcall(require, "toggleterm.terminal") then
				local Terminal = require("toggleterm.terminal").Terminal
				local lazygit = Terminal:new({
					cmd = "lazygit",
					dir = "git_dir",
					direction = "float",
					float_opts = {
						border = "double",
					},
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.keymap.set("n", "q", function()
							vim.cmd("close")
						end, { buffer = term.bufnr, silent = true })
					end,
					on_close = function(term)
						vim.cmd("startinsert!")
					end,
				})

				vim.keymap.set("n", "<leader>g", function()
					lazygit:toggle()
				end, { desc = "Toggle Lazygit", noremap = true, silent = true })
			end
		end,
	})
end
