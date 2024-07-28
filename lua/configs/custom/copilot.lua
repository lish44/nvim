return {
  "github/copilot.vim",
  lazy = false,
  config = function()
    -- vim.g.copilot_proxy = "http://127.0.0.1:1080"
    vim.g.copilot_enabled = true

    -- vim.api.nvim_set_keymap('n', '<leader>go', ':Copilot<CR>', { silent = true })
    -- vim.api.nvim_set_keymap('n', '<leader>ge', ':Copilot enable<CR>', { silent = true })
    -- vim.api.nvim_set_keymap('n', '<leader>gd', ':Copilot disable<CR>', { silent = true })
    vim.api.nvim_set_keymap("i", "<c-p>", "<Plug>(copilot-suggest)", { silent = true })
    vim.api.nvim_set_keymap("i", "<c-n>", "<Plug>(copilot-next)", { silent = true })
    -- vim.api.nvim_set_keymap('i', '<c-l>', '<Plug>(copilot-previous)', { silent = true })
    -- vim.api.nvim_set_keymap("i", "<c-k>", "<Plug>(copilot-accept)", { silent = true })
    --
    -- vim.cmd([[
    -- 	let g:copilot_filetypes = {
    --            \ 'TelescopePrompt': v:false,
    --            \ }
    -- 	]])
    --

    vim.keymap.set("i", "<right>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })
    vim.g.copilot_no_tab_map = true
  end,
}
