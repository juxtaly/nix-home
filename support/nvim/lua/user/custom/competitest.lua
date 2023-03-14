return {
	-- competitest.nvim -- CompetiTest.nvim is a Neovim plugin to automate testcases management and checking for Competitive Programming
	"xeluxee/competitest.nvim",
	dependencies = "MunifTanjim/nui.nvim",
	config = function()
		require("competitest").setup()
	end,
}
