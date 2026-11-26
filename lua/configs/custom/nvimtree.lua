return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
    { "<leader>fe", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in tree" },
  },
  config = function()
    require("nvim-tree").setup {
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      renderer = {
        root_folder_label = false,
      },
    }
  end,
}
