require "nvchad.mappings"

local opt = { noremap = true, silent = true }
local map = vim.keymap.set

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--map('', '<space>', '<NOP>', opt)
--vim.g.mapleader = " "
--vim.g.maplocalleader = " "

-- map('n', '<Leader>h', ':set hlsearch!<CR>', opt)
-- map('n', '<Leader>e', ':Lexplore<CR>', opt)

-- 退出保存
map("n", "<F1>", "<Nop>", opt)

map("n", "q", function()
  local listed = vim.fn.getbufinfo { buflisted = 1 }
  if #listed > 1 then
    vim.cmd "bd"
  else
    vim.cmd "q"
  end
end, opt)
map("n", "Q", ":q!<cr>", opt)
--map("n", "<c-s>", ":w<cr>", opt)

-- 宏映射更改
map("n", "<leader>q", "q", opt)
map("n", "<leader>fm", "<cmd>Telescope lsp_document_symbols<cr>", vim.tbl_extend("force", opt, { desc = "Telescope document symbols" }))

-- move
--map("n", "j", "j", opt)
map("n", "i", "k", opt)
map("n", "k", "i", opt)
map("n", "K", "I", opt)
map("n", "H", "^", opt)
map("n", "L", "$", opt)
map("n", "J", "4j", opt)
map("n", "I", "4k", opt)
-- custom oder
map("n", "cc", "ciw", opt)
map("n", "cd", "$F(lci)", opt)
map("n", "+", "<c-a>", opt)
map("n", "-", "<c-x>", opt)
map("n", "zf", "%", opt)
-- tab
map("n", "<TAB>", ":bnext<CR>", opt)
map("n", "<S-TAB>", ":bprevious<CR>", opt)
-- 分屏操作

-- map('n', '<leader>j', '<c-w>j', opt)
-- map('n', '<leader>h', '<c-w>h', opt)
-- map('n', '<leader>l', '<c-w>l', opt)
-- map('n', 'tw', '<c-w>c', opt)
-- map('n', 'tl', ':set splitright<cr> :vsplit<cr>', opt)
-- map('n', 'th', ':set nosplitright<cr> :vsplit<cr>', opt)
-- map('n', 'ti', ':set nosplitright<cr> :split<cr>', opt)
-- map('n', 'tj', ':set splitright<cr> :split<cr>', opt)
-- map('n', 'to', ':only<cr>', opt)
-- map('n', 'tc', ':tabclose<cr>', opt)
map("n", "rr", "ciw<c-r>0<esc>", opt)
map("n", "R", 'ciw<esc>"+p', opt)
map("n", "cb", ":bd<cr>", opt)
map("n", "<leader>p", '"+p', opt)

map("v", "Y", '"+y', opt)
-- 分屏移动
-- Resize with arrows
map("n", "<M-Down>", ":resize -2<CR>", opt)
map("n", "<M-Up>", ":resize +2<CR>", opt)
map("n", "<M-Left>", ":vertical resize +2<CR>", opt)

local visual_opt = { noremap = true, silent = true, nowait = true }
map("v", "i", "k", visual_opt)
map("v", "k", "i", visual_opt)
map("v", "K", "I", visual_opt)
map("v", "H", "^", visual_opt)
map("v", "L", "$", visual_opt)
map("v", "J", "4j", visual_opt)
map("v", "I", "4k", visual_opt)
-- 在visual 模式里粘贴不复制
map("v", "p", '"_dP', opt)

-- Neovim 0.12 built-in treesitter incremental selection
local function expand_node_selection()
  if vim.fn.mode() == "n" then
    vim.cmd.normal { args = { "v" }, bang = true }
  end

  require("vim.treesitter._select").select_parent(1)
end

local function shrink_node_selection()
  require("vim.treesitter._select").select_child(1)
end

map({ "n", "x" }, "<CR>", expand_node_selection, opt)
map("x", "<BS>", shrink_node_selection, opt)
map("x", "<leader>a", "]n", opt)
map("x", "<leader>i", "[n", opt)

map("i", "jj", "<esc>", opt)
--map("i", "<C-s>", "<esc>:w<enter>", opt)
map("i", "<C-d>", "<del>", opt)
map("i", "<C-f>", "<right>", opt)
map("i", "<C-b>", "<left>", opt)
map("i", "<C-e>", "<end>", opt)

map("x", "<c-j>", ":move '>+1<CR>gv-gv", opt)
map("x", "<c-i>", ":move '<-2<CR>gv-gv", opt)

vim.keymap.set("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

vim.keymap.set("i", "<Down>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Down>"
end, { expr = true })

vim.keymap.set("i", "<Up>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<Up>"
end, { expr = true })

