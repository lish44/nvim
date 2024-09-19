-- 语法建议 错误跳转
return {
	"nvimdev/lspsaga.nvim",
	ft = { "go", "lua" },
	-- event = "BufEnter",
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = { -- 光标所在方法指示路径
				enable = false,
				separator = " › ",
				show_file = true,
				folder_level = 1,
				color_mode = true,
				delay = 200,
			},

			lightbulb = {
				enabled = true,
				sign = false,
				virtual_text = false,
			},
			vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<cr>"),
			vim.keymap.set("n", "<F2>", "<cmd>Lspsaga diagnostic_jump_next<cr>"),
			vim.keymap.set("n", "<F1>", "<cmd>Lspsaga code_action<cr>"),
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
