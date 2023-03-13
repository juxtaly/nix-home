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
