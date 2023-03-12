return function(use)
	use({
		"stevearc/overseer.nvim",
		config = function()
			require("overseer").setup()
		end,
	})
end
