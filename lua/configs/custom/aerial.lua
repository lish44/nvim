return {
  "stevearc/aerial.nvim",
  ft = { "go", "gomod" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Outline" },
  },
  config = function()
    require("aerial").setup {
      layout = {
        default_direction = "right",
      },
      show_guides = true,
      manage_folds = false,
      attach_mode = "window",
    }
  end,
}
