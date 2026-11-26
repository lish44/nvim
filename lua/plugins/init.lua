return {
	{
		"stevearc/conform.nvim",
		lazy = false,
		config = function()
			require("configs.conform")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		opts = function()
			local config = require("nvchad.configs.telescope")
			local actions = require("telescope.actions")

			return vim.tbl_deep_extend("force", config, {
				defaults = {
					mappings = {
						n = {
							i = actions.move_selection_previous,
						},
					},
				},
			})
		end,
	},

	require("configs.custom.copilot"),
	require("configs.custom.editor"),
	require("configs.custom.null-ls"),
	require("configs.custom.treesitter"),
	require("configs.custom.project"),
	require("configs.custom.nvimtree"),
	require("configs.custom.aerial"),
	require("configs.custom.dap"),
	require("configs.custom.go"),
	require("configs.custom.lspsaga"),
	require("configs.custom.flash"),
	require("configs.custom.lazygit"),
	require("configs.custom.mason"),
	require("configs.custom.markdown"),
}
