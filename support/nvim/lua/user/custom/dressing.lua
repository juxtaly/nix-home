return {
	-- dressing.nvim -- Neovim plugin to improve the default vim.ui interfaces
	"stevearc/dressing.nvim",
	config = function()
		require("dressing").setup({
			-- see :help dressing-configuration
		})
	end,
}
