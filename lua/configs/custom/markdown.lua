return {
	lazy = true,
	{
    -- npm config set registry https://registry.npmmirror.com
    -- npm -g install instant-markdown-d

		"instant-markdown/vim-instant-markdown",
		ft = { "markdown" },
		build = "yarn install",
		config = function()
			vim.g.instant_markdown_autostart = 0
			vim.g.instant_markdown_allow_unsafe_content = 1
		end,
	},
	{
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_list = {
				{
					path = '~/Note/note', syntax = 'markdown', ext = '.md'
				}
			}
		end,
		--vim.api.nvim_set_keymap('n', 'gd', ':VimwikiFollowLink<CR>', { silent = true }),
		--vim.api.nvim_set_keymap('n', '<C-o>', ':VimwikiGoBackLink<CR>', { silent = true })
		--ft = { "markdown" },
	},
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	run = "cd app && npm install",
	-- 	setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
	-- 	ft = { "markdown" }
	-- },
}
