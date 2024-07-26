return {
  "nvimdev/lspsaga.nvim",
  ft = "go",
  config = function()
    require("lspsaga").setup {}
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
