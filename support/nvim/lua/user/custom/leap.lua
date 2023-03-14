return {
	-- leap.nvim -- 🦘 Neovim's answer to the mouse
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		require("leap").add_default_mappings(true)
		-- see :help leap-config
	end,
}
