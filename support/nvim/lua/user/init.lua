local M = {}

function M.setup()
	require("user.defaults.sensible")
  require("user.defaults.extra")

	-- Install package manager
	--    https://github.com/folke/lazy.nvim
	--    `:help lazy.nvim.txt` for more info
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end

	vim.opt.rtp:prepend(lazypath)

	-- NOTE: Here is where you install your plugins.
	--  You can configure plugins using the `config` key.
	--
	--  You can also configure plugins after the setup call,
	--    as they will be available in your neovim runtime.
	require("lazy").setup({
		-- NOTE: First, some plugins that don't require any configuration
		"nvim-lua/plenary.nvim",

		-- Git related plugins
		"tpope/vim-fugitive",
		"tpope/vim-rhubarb",

		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",

		-- NOTE: This is where your plugins related to LSP can be installed.
		--  The configuration is done below. Search for lspconfig to find it below.
		{
			-- LSP Configuration & Plugins
			"neovim/nvim-lspconfig",
			dependencies = {
				-- Automatically install LSPs to stdpath for neovim
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",

				-- Useful status updates for LSP
				-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
				{ "j-hui/fidget.nvim", opts = {} },

				-- Additional lua configuration, makes nvim stuff amazing!
				"folke/neodev.nvim",
			},
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			dependencies = { "jay-babu/mason-null-ls.nvim" },
		},
		{
			-- DAP Configuration & Plugins
			"mfussenegger/nvim-dap",
			dependencies = {
				"williamboman/mason.nvim",
				"jay-babu/mason-nvim-dap.nvim",
				"rcarriga/nvim-dap-ui",
			},
		},
		{
			-- neotest -- An extensible framework for interacting with tests within NeoVim.
			"nvim-neotest/neotest",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
				"rouge8/neotest-rust", -- Require 'cargo install cargo-nextest'
			},
		},
		{
			-- Autocompletion
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-document-symbol",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
			},
		},
		{
			"windwp/nvim-autopairs",
			opts = {},
		},
		-- Useful plugin to show you pending keybinds.
		{ "folke/which-key.nvim", opts = {} },
		{
			-- Adds git releated signs to the gutter, as well as utilities for managing changes
			"lewis6991/gitsigns.nvim",
			opts = {
				-- See `:help gitsigns.txt`
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			},
		},

		{
			-- Theme inspired by Atom
			"navarasu/onedark.nvim",
			priority = 1000,
			config = function()
				vim.cmd.colorscheme("onedark")
			end,
		},

		{
			-- Set lualine as statusline
			"nvim-lualine/lualine.nvim",
			-- See `:help lualine.txt`
			opts = {
				options = {
					icons_enabled = false,
					theme = "onedark",
					component_separators = "|",
					section_separators = "",
				},
			},
		},

		{
			-- Add indentation guides even on blank lines
			"lukas-reineke/indent-blankline.nvim",
			-- Enable `lukas-reineke/indent-blankline.nvim`
			-- See `:help indent_blankline.txt`
			opts = {
				char = "┊",
				show_trailing_blankline_indent = false,
			},
		},

		-- "gc" to comment visual regions/lines
		{ "numToStr/Comment.nvim", opts = {} },

		-- Fuzzy Finder (files, lsp, etc)
		{ "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } },

		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},

		{
			-- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			dependencies = {
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			config = function()
				pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			end,
		},

		-- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
		--       These are some example plugins that I've included in the kickstart repository.
		--       Uncomment any of the lines below to enable them.
		-- require 'kickstart.plugins.autoformat',
		-- require 'kickstart.plugins.debug',

		-- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
		--    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
		--    up-to-date with whatever is in the kickstart repo.
		--
		--    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
		--
		--    An additional note is that if you only copied in the `init.lua`, you can just comment this line
		--    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
		{ import = "user.custom" },
	}, {})

	local setup_lualine = function()
		local ok, lualine = pcall(require, "lualine")
		if not ok then
			return
		end

    -- Eviline config for lualine
    -- Author: shadmansaleh
    -- Credit: glepnir

    -- Color table for highlights
    -- stylua: ignore
    local colors = {
      bg       = '#202328',
      fg       = '#bbc2cf',
      yellow   = '#ECBE7B',
      cyan     = '#008080',
      darkblue = '#081633',
      green    = '#98be65',
      orange   = '#FF8800',
      violet   = '#a9a1e1',
      magenta  = '#c678dd',
      blue     = '#51afef',
      red      = '#ec5f67',
    }

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				component_separators = "",
				section_separators = "",
				theme = {
					-- We are going to use lualine_c an lualine_x as left and
					-- right section. Both are highlighted by c theme .  So we
					-- are just setting default looks o statusline
					normal = { c = { fg = colors.fg, bg = colors.bg } },
					inactive = { c = { fg = colors.fg, bg = colors.bg } },
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			extensions = { "aerial", "nvim-tree", "quickfix", "toggleterm" },
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x ot right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left({
			function()
				return "▊"
			end,
			color = { fg = colors.blue }, -- Sets highlighting of component
			padding = { left = 0, right = 1 }, -- We don't need space before this
		})

		ins_left({
			-- mode component
			function()
				return ""
			end,
			color = function()
				-- auto change color according to neovims mode
				local mode_color = {
					n = colors.red,
					i = colors.green,
					v = colors.blue,
					[""] = colors.blue,
					V = colors.blue,
					c = colors.magenta,
					no = colors.red,
					s = colors.orange,
					S = colors.orange,
					[""] = colors.orange,
					ic = colors.yellow,
					R = colors.violet,
					Rv = colors.violet,
					cv = colors.red,
					ce = colors.red,
					r = colors.cyan,
					rm = colors.cyan,
					["r?"] = colors.cyan,
					["!"] = colors.red,
					t = colors.red,
				}
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { right = 1 },
		})

		ins_left({
			-- filesize component
			"filesize",
			cond = conditions.buffer_not_empty,
		})

		ins_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = { fg = colors.magenta, gui = "bold" },
		})

		ins_left({ "location" })

		ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				color_error = { fg = colors.red },
				color_warn = { fg = colors.yellow },
				color_info = { fg = colors.cyan },
			},
		})

		-- Insert mid section. You can make any number of sections in neovim :)
		-- for lualine it's any number greater then 2
		ins_left({
			function()
				return "%="
			end,
		})

		ins_left({
			-- Lsp server name .
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " LSP:",
			color = { fg = "#ffffff", gui = "bold" },
		})

		-- Add components to right sections
		ins_right({
			"o:encoding", -- option component same as &encoding in viml
			fmt = string.upper, -- I'm not sure why it's upper case either ;)
			cond = conditions.hide_in_width,
			color = { fg = colors.green, gui = "bold" },
		})

		ins_right({
			"fileformat",
			fmt = string.upper,
			icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
			color = { fg = colors.green, gui = "bold" },
		})

		ins_right({
			"branch",
			icon = "",
			color = { fg = colors.violet, gui = "bold" },
		})

		ins_right({
			"diff",
			-- Is it me or the symbol for modified us really weird
			symbols = { added = " ", modified = "柳 ", removed = " " },
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
			cond = conditions.hide_in_width,
		})

		ins_right({
			function()
				return "▊"
			end,
			color = { fg = colors.blue },
			padding = { left = 1 },
		})

		-- Now don't forget to initialize lualine
		lualine.setup(config)
	end
	setup_lualine()

	local setup_telescope = function()
		local ok, telescope = pcall(require, "telescope")
		if not ok then
			return
		end

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},
		})

		-- Enable telescope fzf native, if installed
		pcall(telescope.load_extension, "fzf")

		-- See `:help telescope.builtin`
		vim.keymap.set(
			"n",
			"<leader>?",
			require("telescope.builtin").oldfiles,
			{ desc = "[?] Find recently opened files" }
		)
		vim.keymap.set(
			"n",
			"<leader><space>",
			require("telescope.builtin").buffers,
			{ desc = "[ ] Find existing buffers" }
		)
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer]" })

		vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set(
			"n",
			"<leader>sw",
			require("telescope.builtin").grep_string,
			{ desc = "[S]earch current [W]ord" }
		)
		vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
	end
	setup_telescope()

	local setup_treesitter = function()
		local ok, configs = pcall(require, "nvim-treesitter.configs")
		if not ok then
			return
		end

		-- [[ Configure Treesitter ]]
		-- See `:help nvim-treesitter`
		configs.setup({
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "nix", "help", "vim" },
			auto_install = false,
			highlight = { enable = true },
			indent = { enable = true, disable = { "python" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})
	end
	setup_treesitter()
	require("neodev").setup({
		library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
	})

	local setup_lsp = function()
		-- Diagnostic keymaps
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

		local _nmap = function(bufnr)
			return function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end
		end

		-- Keymaps that can be used for null_ls
		function _G.set_lsp_keymaps_basic(bufnr)
			local nmap = _nmap(bufnr)
			nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			-- See `:help K` for why this keymap
			nmap("K", vim.lsp.buf.hover, "Hover Documentation")
			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })
		end

		function _G.set_lsp_keymaps(bufnr)
			local nmap = _nmap(bufnr)
			set_lsp_keymaps_basic(bufnr)
			nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

			nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
			nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

			-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

			-- Lesser used LSP functionality
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")
		end

		-- LSP settings.
		--  This function gets run when an LSP connects to a particular buffer.
		local on_attach = function(_, bufnr)
			set_lsp_keymaps(bufnr)
		end

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. They will be passed to
		--  the `settings` field of the server config. You must look up that documentation yourself.
		local servers = {
			-- clangd = {},
			-- gopls = {},
			-- pyright = {},
			-- rust_analyzer = {},
			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
			-- tsserver = {},
			fennel_language_server = {
				fennel = {
					workspace = {
						library = vim.api.nvim_list_runtime_paths(),
					},
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		if pcall(require, "cmp_nvim_lsp") then
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
		end

		-- Setup mason so it can manage external tooling
		if pcall(require, "mason") then
			require("mason").setup()
		end

		-- Ensure the servers above are installed
		local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
		if ok then
			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			local lspconfig = require("lspconfig")

			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
					})
				end,
				["rust_analyzer"] = function()
					-- in rust-tools.lua
				end,
				["hls"] = function()
					-- in ftplugin
				end,
				["fennel_language_server"] = function()
					require("lspconfig.configs").fennel_language_server = {
						default_config = {
							cmd = { "fennel-language-server" },
							filetypes = { "fennel" },
							single_file_support = true,
							root_dir = lspconfig.util.root_pattern("fnl"),
						},
					}
					lspconfig.fennel_language_server.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers["fennel_language_server"],
					})
				end,
			})
		end

		-- Turn on lsp status information
		if pcall(require, "fidget") then
			require("fidget").setup()
		end

		local has_null_ls, null_ls = pcall(require, "null-ls")
		if has_null_ls then
			local has_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")
			if has_mason_null_ls then
				mason_null_ls.setup({
					ensure_installed = { "stylua" },
					automatic_setup = true,
				})
				mason_null_ls.setup_handlers({
					function(source_name, methods)
						-- all sources with no handler get passed here

						-- To keep the original functionality of `automatic_setup = true`,
						-- please add the below.
						require("mason-null-ls.automatic_setup")(source_name, methods)
					end,
					stylua = function(source_name, methods) -- no need if automatic_setup is set to true
						null_ls.register(null_ls.builtins.formatting.stylua)
					end,
				})
			end
			local sources = {
				-- Anything not supported by mason
			}
			local packages = {
				code_actions = { "statix", "shellcheck" },
				completion = {},
				diagnostics = { "deadnix", "statix", "shellcheck" },
				formatting = { "alejandra" },
				hover = {},
			}
			local source_mappings = require("mason-null-ls.mappings.source")
			for methods, ps in pairs(packages) do
				for _, pkg in ipairs(ps) do
					if vim.fn.executable(pkg) == 1 then
						local source_name = source_mappings.getNullLsFromPackage(pkg)
						local source = null_ls.builtins[methods][source_name]
						if source then
							table.insert(sources, source)
						end
					end
				end
			end

			null_ls.setup({
				sources = sources,
			})
		end
	end

	setup_lsp()
	local setup_dap = function()
		local mason_nvim_dap_ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")
		if mason_nvim_dap_ok then
			mason_nvim_dap.setup({
				automatic_setup = true,
			})
			mason_nvim_dap.setup_handlers()
		end

		local dap_ok, dap = pcall(require, "dap")
		if dap_ok then
			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end, { desc = "DAP: Continue" })
			vim.keymap.set("n", "<F6>", function()
				require("dap").step_over()
			end, { desc = "DAP: Step over" })
			vim.keymap.set("n", "<F7>", function()
				require("dap").step_into()
			end, { desc = "DAP: Step into" })
			vim.keymap.set("n", "<F8>", function()
				require("dap").step_out()
			end, { desc = "DAP: Step out" })
			vim.keymap.set("n", "<Leader>b", function()
				require("dap").toggle_breakpoint()
			end, { desc = "DAP: Toggle [B]reakpoint" })
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end, { desc = "DAP: Open [R]epl" })
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").run_last()
			end, { desc = "DAP: Run [L]ast" })
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "DAP: [H]over" })
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				require("dap.ui.widgets").preview()
			end, { desc = "DAP: [P]review" })
			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end, { desc = "DAP: Show [F]rames" })
			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, { desc = "DAP: Show [S]copes" })

			local dapui_ok, dapui = pcall(require, "dapui")
			if dapui_ok then
				dapui.setup({
					controls = {
						enabled = false,
					},
					icons = {
						collapsed = ">",
						current_frame = "=",
						expanded = "v",
					},
				})
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close()
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
				end
			end
		end
	end
	setup_dap()

	local setup_neotest = function()
		local ok, neotest = pcall(require, "neotest")
		if not ok then
			return
		end

		neotest.setup({
			adapters = {
				require("neotest-rust"),
			},
			icons = {
				child_indent = "│",
				child_prefix = "├",
				collapsed = "─",
				expanded = "╮",
				failed = "x",
				final_child_indent = " ",
				final_child_prefix = "╰",
				non_collapsible = "─",
				passed = "P",
				running = "R",
				running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
				skipped = "S",
				unknown = "U",
			},
		})

		vim.keymap.set("n", "<F9>", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, { desc = "Test: Run all tests in this file" })
		vim.keymap.set("n", "<F10>", function()
			require("neotest").summary.toggle()
		end, { desc = "Test: Toggle summary" })
	end
	setup_neotest()
	local setup_cmp = function()
		local ok, cmp = pcall(require, "cmp")
		if not ok then
			return
		end

		local kind_icons = {
			Text = "",
			Method = "",
			Function = "",
			Constructor = "",
			Field = "",
			Variable = "",
			Class = "ﴯ",
			Interface = "",
			Module = "",
			Property = "ﰠ",
			Unit = "",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		}

		local function cmp_set_hl(hl_groups, fg)
			local first = hl_groups[1]
			for i, hl_group in ipairs(hl_groups) do
				if i == 1 then
					vim.api.nvim_set_hl(0, hl_group, {
						bg = "NONE",
						fg = fg,
					})
				else
					vim.api.nvim_set_hl(0, hl_group, {
						link = first,
					})
				end
			end
		end

		-- " gray
		vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", {
			strikethrough = true,
			bg = "NONE",
			fg = "#808080",
		})
		-- " blue
		cmp_set_hl({ "CmpItemAbbrMatch", "CmpItemAbbrMatchFuzzy" }, "#569CD6")
		-- " light blue
		cmp_set_hl({ "CmpItemKindVariable", "CmpItemKindInterface", "CmpItemKindText" }, "#9CDCFE")
		-- " pink
		cmp_set_hl({ "CmpItemKindFunction", "CmpItemKindMethod" }, "#C586C0")
		-- " front
		cmp_set_hl({ "CmpItemKindKeyword", "CmpItemKindProperty", "CmpItemKindUnit" }, "#D4D4D4")

		local has_luasnip, luasnip = pcall(require, "luasnip")

		local expand_snippet = function(args)
			if has_luasnip then
				luasnip.lsp_expand(args.body)
			end
		end

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		local super_tab = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_luasnip and luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end

		local super_stab = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif has_luasnip and luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end

		cmp.setup({
			snippet = {
				expand = expand_snippet,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
					-- Source
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						path = "[Path]",
						nvim_lsp_document_symbol = "[Doc Sym]",
						cmdline = "[CMD]",
					})[entry.source.name]
					return vim_item
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping(super_tab, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(super_stab, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer", keyword_length = 5 },
			}),
			experimental = {
				native_menu = false,
				ghost_text = true,
			},
			enabled = function()
				-- disable completion in comments
				local context = require("cmp.config.context")
				-- keep command mode completion enabled when cursor is in a comment
				if vim.api.nvim_get_mode().mode == "c" then
					return true
				else
					return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
				end
			end,
		})

		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "buffer" },
			}),
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "nvim_lsp_document_symbol" }, -- Trigger: @
			},
			{
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		local has_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
		if has_autopairs then
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end
	setup_cmp()
end

return M

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
