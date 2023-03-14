return {
	-- nvim-nu -- Basic editor support for the nushell language
	"LhKipp/nvim-nu",
	config = function()
		require("nu").setup({})
	end,
}
