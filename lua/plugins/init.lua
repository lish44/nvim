return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		config = function()
			require("configs.conform")
		end,
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},
	{
		require("configs.custom.copilot"),
		require("configs.custom.editor"),
		require("configs.custom.null-ls"),
		require("configs.custom.treesitter"),
		require("configs.custom.dap"),
		require("configs.custom.go"),
		require("configs.custom.lspsaga"),
		require("configs.custom.flash"),
		require("configs.custom.lazygit"),
		require("configs.custom.mason"),
	},
}
