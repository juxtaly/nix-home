return {
	-- nvim-tree.lua -- A file explorer tree for neovim written in lua
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nt = require("nvim-tree")
		local api = require("nvim-tree.api")
		nt.setup({
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
		})
		vim.keymap.set("n", "<leader>f", function()
			api.tree.toggle({
				find_file = true,
			})
		end, { silent = true, desc = "Toggle NvimTree" })
		vim.api.nvim_create_user_command("NvimTreeOpenFilesUnderCursor", function()
			local node = api.tree.get_node_under_cursor()
			if node.nodes then
				local opend = 0
				for _, cnode in ipairs(node.nodes) do
					if opend > 50 then
						vim.notify("Too many files opend!", vim.log.levels.WARN)
						return
					end
					if not cnode.nodes then
						api.node.open.tab(cnode)
						opend = opend + 1
					end
				end
			else
				api.node.open.tab(node)
			end
		end, { desc = "Open all files belonging to the code under the cursor, one level deep" })
		vim.api.nvim_create_autocmd({ "QuitPre" }, {
			callback = api.tree.close,
		})
	end,
}
