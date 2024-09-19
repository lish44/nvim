return {
  "williamboman/mason.nvim",
  opts = {
    -- ensure_installed = {
    -- "lua-language-server",
    -- "stylua",
    -- "gopls",
    -- },
    mason = { cmd = true, pkgs = { "lua-language-server", "stylua", "gopls"} },
  },
}
