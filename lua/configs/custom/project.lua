return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  config = function()
    require("project_nvim").setup {
      detection_methods = { "pattern" },
      patterns = { "go.work", "go.mod", ".git" },
      silent_chdir = true,
    }

    pcall(require("telescope").load_extension, "projects")
  end,
  keys = {
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
  },
}
