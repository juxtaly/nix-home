return {
	-- nvim-nu -- Basic editor support for the nushell language
	"LhKipp/nvim-nu",
	config = function()
		require("nu").setup({})
		local bufnr = vim.api.nvim_get_current_buf()
		set_lsp_keymaps_basic(bufnr)
	end,
	ft = "nu",
}
