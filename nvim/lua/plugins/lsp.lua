-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Move to the previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Move to the next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostica in a floating window" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Add buffer diagnostics to the location list" })

function _G.set_lsp_keymaps(bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
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
	lua_ls = {},
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
			require("custom.rust-tools.setup")()
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
		code_actions = { "statix" },
		completion = {},
		diagnostics = { "deadnix", "statix" },
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
