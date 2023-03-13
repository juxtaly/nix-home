local function plugins(use)
	local plist = {
		-- which-key.nvim -- 💥 Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
		"which-key",
		-- leap.nvim -- 🦘 Neovim's answer to the mouse
		"leap",
		-- nvim-tree.lua -- A file explorer tree for neovim written in lua
		"nvim-tree",
		-- neoscroll.nvim -- Smooth scrolling neovim plugin written in lua
		"neoscroll",
		-- dressing.nvim -- Neovim plugin to improve the default vim.ui interfaces
		"dressing",
		-- marks.nvim -- A better user experience for viewing and interacting with Vim marks.
		"marks",
		-- toggleterm.nvim -- A neovim lua plugin to help easily manage multiple terminal windows
		"toggleterm",
		-- trouble.nvim -- 🚦 A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
		"trouble",
		-- noice.nvim -- 💥 Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
		"noice",
		-- zen-mode.nvim -- 🧘 Distraction-free coding for Neovim
		"zen-mode",
		-- competitest.nvim -- CompetiTest.nvim is a Neovim plugin to automate testcases management and checking for Competitive Programming
		"competitest",
		-- aerial.nvim -- Neovim plugin for a code outline window
		"aerial",
		-- overseer.nvim -- A task runner and job management plugin for Neovim
		"overseer",
		-- haskell-tools.nvim -- Supercharge your Haskell experience in neovim!
		"haskell-tools",
		-- rust-tools.nvim -- Tools for better development in rust using neovim's builtin lsp
		"rust-tools",
		-- ChatGPT.nvim -- Neovim plugin for interacting with OpenAI GPT-3 chatbot, providing an easy interface for exploring GPT-3 and NLP.
		"ChatGPT",
		-- alpha-nvim -- a lua powered greeter like vim-startify / dashboard-nvim
		"alpha",
		-- TODO: default mapping conflict with leap.nvim, consider change default mappings of leap.nvim
		-- nvim-surround -- Add/change/delete surrounding delimiter pairs with ease. Written with ❤️ in Lua.
		-- "surround",
		-- project.nvim -- The superior project management solution for neovim.
		"project",
		-- nvim-nu -- Basic editor support for the nushell language
		"nu",
	}
	for _, plugin in ipairs(plist) do
		require("custom." .. plugin)(use)
	end
end

return plugins
