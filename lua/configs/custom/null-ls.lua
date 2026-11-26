return {
  "nvimtools/none-ls.nvim",
  ft = "go",
  config = function()
    require("null-ls").setup {}
  end,
}
