return {
  {
    "RRethy/vim-illuminate", -- 字符高亮插件
    event = { "BufReadPost", "BufNewFile" },
    --BufReadPost: 当一个缓冲区（buffer）被读取完成后触发 
    --BufNewFile: 开始编辑一个新文件（即当前缓冲区是一个新建文件）时触发
    config = function()
      require("illuminate").configure {
        providers = {
          "lsp",
          --'treesitter',
          --'regex',
        },
      }
      -- vim.cmd "hi IlluminatedWordText guibg=#4C566A gui=none"
      vim.cmd("hi IlluminatedWordText guibg=#ecf0f1 gui=none")
    end,
  },
  {
    "dkarter/bullets.vim", -- 回车自动写数字插件
    ft = { "markdown", "txt" },
  },
  {
    "psliwka/vim-smoothie", -- 翻页有更顺滑smooth
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.cmd [[nnoremap <unique> <C-e> <cmd>call smoothie#do("\<C-D>") <CR>]]
      vim.cmd [[nnoremap <unique> <C-u> <cmd>call smoothie#do("\<C-U>") <CR>]]
    end,
  },
}
