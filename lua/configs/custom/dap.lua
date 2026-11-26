return {
	"mfussenegger/nvim-dap",
	lazy = true,
	ft = "go",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dap.defaults.fallback.force_external_terminal = false
		dap.defaults.fallback.external_terminal = nil

		vim.api.nvim_create_user_command("DapGoDebugPackage", function()
			dap.run({
				type = "go",
				name = "Debug Package",
				request = "launch",
				program = vim.fn.getcwd(),
				outputMode = "remote",
			})
		end, {})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "go", "gomod" },
			callback = function(args)
				local opts = { buffer = args.buf, noremap = true, silent = true }
				vim.keymap.set("n", "<F5>", dap.continue, vim.tbl_extend("force", opts, { desc = "Debug: Start/Continue" }))
				vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "Debug: Toggle Breakpoint" }))
				vim.keymap.set("n", "<F7>", dap.step_into, vim.tbl_extend("force", opts, { desc = "Debug: Step Into" }))
				vim.keymap.set("n", "<F8>", dap.step_over, vim.tbl_extend("force", opts, { desc = "Debug: Step Over" }))
				vim.keymap.set("n", "<F6>", dap.step_out, vim.tbl_extend("force", opts, { desc = "Debug: Step Out" }))
				vim.keymap.set("n", "<leader>dd", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "Debug: Toggle Breakpoint" }))
				vim.keymap.set("n", "<leader>db", function()
					dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end, vim.tbl_extend("force", opts, { desc = "Debug: Set Breakpoint" }))
				vim.keymap.set("n", "<leader>gd", function()
					require("dap-go").debug_test()
				end, vim.tbl_extend("force", opts, { desc = "Debug: Nearest Go test" }))
				vim.keymap.set("n", "<leader>gD", function()
					require("dap-go").debug_last_test()
				end, vim.tbl_extend("force", opts, { desc = "Debug: Last Go test" }))
				vim.keymap.set("n", "<leader>dr", "<cmd>DapGoDebugPackage<cr>", vim.tbl_extend("force", opts, { desc = "Debug: Run current project" }))
				vim.keymap.set("n", "<leader>dc", dap.terminate, vim.tbl_extend("force", opts, { desc = "Debug: Stop" }))
				vim.keymap.set("n", "<leader>dl", dapui.toggle, vim.tbl_extend("force", opts, { desc = "Debug: Toggle UI" }))
			end,
		})

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			handlers = {},
			ensure_installed = {
				"delve",
			},
		})

		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.5 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{ id = "repl", size = 0.7 },
						{ id = "console", size = 0.3 },
					},
					position = "bottom",
					size = 15,
				},
			},
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		require("dap-go").setup({
			delve = {
				detached = vim.fn.has("win32") == 0,
			},
			dap_configurations = {
				{
					type = "go",
					name = "Debug Package (cwd)",
					request = "launch",
					program = vim.fn.getcwd,
					outputMode = "remote",
				},
			},
		})
	end,
}
