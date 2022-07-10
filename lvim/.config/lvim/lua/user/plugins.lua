lvim.plugins = {
  -- Last modified:   2022-07-07 16:59:57
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
  { "mhinz/vim-signify" }, --Signify (or just Sy) uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system (VCS).

  { "folke/tokyonight.nvim" },
  {
    -- Python-mode, a Python IDE for Vim
    "python-mode/python-mode",
    branch = "develop",
  },
  {
    "pchaos/timestamp.vim",
    -- branch = "master",
    branch = "dev",
    -- When a file is written, and the filename matches |timestamp_automask|, this plugin will search the first and last |timestamp_modelines| lines of your file. If it finds the regexp |timestamp_regexp| then it will replace it with a timestamp. The timestamp is computed by first doing a |token_substitution| on |timestamp_rep| and passing the result to |strftime()|.
    -- For instance, if you create a new file and want to stamp it with a creation date and a last modified date, make the first few lines: >
    --    Created:            TIMESTAMP
    --    Last modified:      TIMESTAMP
    --    Modified:      TIMESTAMP
    --    Changed:       TIMESTAMP
  },
  { "pchaos/fcitx5-status" },
}

local noused_plugins = {
  {
    -- barbar.nvim is a tabline plugin with re-orderable, auto-sizing, clickable tabs, icons, nice highlighting, sort-by commands and a magic jump-to-buffer mode. Plus the tab names are made unique when two filenames match.
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('barbar').setup()
    end
  },
}
