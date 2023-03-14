return {
	-- rust-tools.nvim -- Tools for better development in rust using neovim's builtin lsp
	"simrat39/rust-tools.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		local rt = require("rust-tools")
		rt.setup({
			server = {
				on_attach = function(_, bufnr)
					set_lsp_keymaps(bufnr)
					vim.keymap.set(
						"n",
						"<localleader>ha",
						rt.hover_actions.hover_actions,
						{ buffer = bufnr, desc = "Rust: [H]over [A]ctions" }
					)
					vim.keymap.set(
						"n",
						"<localleader>cA",
						rt.code_action_group.code_action_group,
						{ buffer = bufnr, desc = "Rust: [C]ode [A]ction group" }
					)
				end,
			},
			dap = {
				adapter = {
					type = "server",
					port = "${port}",
					executable = {
						command = "codelldb",
						args = { "--port", "${port}" },
					},
				},
			},
		})
	end,
}
