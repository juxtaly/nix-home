return function(use)
	use({
		"LhKipp/nvim-nu",
		config = function()
			require("nu").setup({})
		end,
	})
end
