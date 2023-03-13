return function(use)
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
			local ok, telescope = pcall(require, "telescope")
			if ok then
				if pcall(telescope.load_extension, "projects") then
					vim.keymap.set(
						"n",
						"<leader>sp",
						require("telescope").extensions.projects.projects,
						{ desc = "[S]earch [P]rojects" }
					)
				end
			end
		end,
	})
end
