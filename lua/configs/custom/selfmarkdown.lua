vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 0

vim.api.nvim_set_keymap('i', ',m', '<Esc>/<++><CR>:nohlsearch<CR>c4l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',n', '---<Enter><Enter>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', ',b', '**** <++><Esc>F*hi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',s', '~~~~ <++><Esc>F~hi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',i', '** <++><Esc>F*i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',d', '`` <++><Esc>F`i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',c', '```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',p', '![](../pic/<++>) <++><Esc>F[a', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',a', '[](<++>) <++><Esc>F[a', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',l', '--------<Enter>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',z', '[]()[<++>](<++>)<Esc>F(;a', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', ',1', '#<Space><Enter><++><Esc>kA', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',2', '##<Space><Enter><++><Esc>kA', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',3', '###<Space><Enter><++><Esc>kA', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',4', '####<Space><Enter><++><Esc>kA', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',5', '#####<Space><Enter><++><Esc>kA', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',6', '######<Space><Enter><++><Esc>kA', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', ',R', '<font color=#bf616a></font><Space><++><Esc>2F<i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',G', '<font color=#a3be8c></font><Space><++><Esc>2F<i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',B', '<font color=#81a1c1></font><Space><++><Esc>2F<i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',Y', '<font color=#ebcb8b></font><Space><++><Esc>2F<i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',M', '<font color=#b48ead></font><Space><++><Esc>2F<i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',N', '<font color=#3b4252></font><Space><++><Esc>2F<i', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', ',k', '<kbd></kbd><++><Esc>F<;i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',r', '[return](./index.md)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ',t', ':-------:', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', ',b', 's**<esc>pa**<esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ',s', 's~~<esc>pa~~<esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ',i', 's*<esc>pa*<esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ',d', 's`<esc>pa`<esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ',R', 's<font color=#bf616a><esc>pa</font><esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ',G', 's<font color=#a3be8c><esc>pa</font><esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ',B', 's<font color=#81a1c1><esc>pa</font><esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ',Y', 's<font color=#ebcb8b><esc>pa</font><esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ',M', 's<font color=#b48ead><esc>pa</font><esc>', { noremap = true, silent = true })
