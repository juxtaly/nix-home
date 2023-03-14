return {
	-- alpha-nvim -- a lua powered greeter like vim-startify / dashboard-nvim
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("alpha").setup(require("alpha.themes.startify").config)
	end,
}
