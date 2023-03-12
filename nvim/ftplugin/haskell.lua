local ok, ht = pcall(require, "haskell-tools")
if not ok then
	return
end

local def_opts = { noremap = true, silent = true }
ht.start_or_attach({
	hls = {
		on_attach = function(_, bufnr)
			set_lsp_keymaps(bufnr)
			local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr })
			-- haskell-language-server relies heavily on codeLenses,
			-- so auto-refresh (see advanced configuration) is enabled by default
			vim.keymap.set(
				"n",
				"<localleader>cr",
				vim.lsp.codelens.run,
				vim.tbl_extend("keep", opts, { desc = "LSP: [C]odelens [R]un" })
			)
			vim.keymap.set(
				"n",
				"<localleader>hs",
				ht.hoogle.hoogle_signature,
				vim.tbl_extend("keep", opts, { desc = "Haskell: [H]oogle [S]earch" })
			)
			vim.keymap.set(
				"n",
				"<localleader>ea",
				ht.lsp.buf_eval_all,
				vim.tbl_extend("keep", opts, { desc = "Haskell: buffer [E]val [A]ll" })
			)
		end,
	},
})

-- Suggested keymaps that do not depend on haskell-language-server:
local bufnr = vim.api.nvim_get_current_buf()
-- set buffer = bufnr in ftplugin/haskell.lua
local opts = { noremap = true, silent = true, buffer = bufnr }

-- Toggle a GHCi repl for the current package
vim.keymap.set(
	"n",
	"<localleader>rr",
	ht.repl.toggle,
	vim.tbl_extend("keep", opts, { desc = "Haskell: toggle GHCi [R]epl for the current package" })
)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<localleader>rf", function()
	ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, vim.tbl_extend("keep", def_opts, { desc = "Haskell: toggle GHCi [R]epl for the current buffer" }))
vim.keymap.set("n", "<localleader>rq", ht.repl.quit, vim.tbl_extend("keep", opts, { desc = "Haskell: [R]epl [Q]uit" }))
