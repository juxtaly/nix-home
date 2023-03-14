return {
	-- noice.nvim -- 💥 Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
	"folke/noice.nvim",
	config = function()
		require("noice").setup({
			-- add any options here
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- NOTE: noice has issues with neovide
			-- See: https://github.com/folke/noice.nvim/issues/17
			--      https://github.com/neovide/neovide/issues/1751
			--      https://github.com/neovim/neovim/issues/22344
			-- Seems like disabling messages suspends these issues
			messages = {
				enabled = false,
				-- view = false, -- default view for messages
				-- view_error = "notify", -- view for errors
				-- view_warn = "notify", -- view for warnings
				-- view_history = "messages", -- view for :messages
				-- view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
			},
		})

		vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
			if not require("noice.lsp").scroll(4) then
				return "<c-f>"
			end
		end, { silent = true, expr = true })

		vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
			if not require("noice.lsp").scroll(-4) then
				return "<c-b>"
			end
		end, { silent = true, expr = true })
	end,
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
}
