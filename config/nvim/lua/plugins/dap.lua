return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- "rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"jay-babu/mason-nvim-dap.nvim",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		-- local ui = require("dapui")
		local dap = require("dap")
		local map = vim.keymap.set

		-- require("dapui").setup()
		require("nvim-dap-virtual-text").setup()

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}

		dap.configurations.cpp = {
			{
				name = "Launch GDB (C/C++/Zig)",
				type = "gdb",
				request = "launch",
				projectDir = "${workspaceFolder}",
				program = "${command:pickFile}",
				stopOnEntry = false,
			},
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.zig = dap.configurations.cpp

		-- Keymaps
		map("n", "<F1>", dap.continue)
		map("n", "<S-F1>", dap.restart)
		map("n", "<F2>", dap.step_over)
		map("n", "<F3>", dap.step_into)
		map("n", "<F4>", dap.terminate)
		map("n", "<F5>", dap.toggle_breakpoint)

		-- Listeners for UI interaction
		-- dap.listeners.before.attach.dapui_config = function()
		-- 	ui.open()
		-- end
		-- dap.listeners.before.launch.dapui_config = function()
		-- 	ui.open()
		-- end
		-- dap.listeners.before.event_terminated.dapui_config = function()
		-- 	ui.close()
		-- end
		-- dap.listeners.before.event_exited.dapui_config = function()
		-- 	ui.close()
		-- end
	end,
}
