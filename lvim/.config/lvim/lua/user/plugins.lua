lvim.plugins = {
	-- Last Modified: 一 04 7月 2022 07:10:56 下午 PST
	{
		"felipec/vim-sanegx",
		event = "BufRead",
	},
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 0
		end,
	},
	{ "LunarVim/Colorschemes" },
	{ "folke/tokyonight.nvim" },
	{ "vim-scripts/timestamp.vim" }, -- When a file is written, and the filename matches |timestamp_automask|, this plugin will search the first and last |timestamp_modelines| lines of your file. If it finds the regexp |timestamp_regexp| then it will replace it with a timestamp. The timestamp is computed by first doing a |token_substitution| on |timestamp_rep| and passing the result to |strftime()|.
	{ "pchaos/fcitx5-status" },
}

local tempplugins = {
	{
		-- barbar.nvim is a tabline plugin with re-orderable, auto-sizing, clickable tabs, icons, nice highlighting, sort-by commands and a magic jump-to-buffer mode. Plus the tab names are made unique when two filenames match.
		'romgrk/barbar.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('barbar').setup()
		end
	},
}
