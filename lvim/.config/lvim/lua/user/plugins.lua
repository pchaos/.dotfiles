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

  { "kshenoy/vim-signature",
    --o vim-signature is a plugin to place, toggle and display marks.
    --   mx           Toggle mark 'x' and display it in the leftmost column
    -- dmx          Remove mark 'x' where x is a-zA-Z

    -- m,           Place the next available mark
    -- m.           If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
    -- m-           Delete all marks from the current line
    -- m<Space>     Delete all marks from the current buffer
    -- ]`           Jump to next mark
    -- [`           Jump to prev mark
    -- ]'           Jump to start of next line containing a mark
    -- ['           Jump to start of prev line containing a mark
    -- `]           Jump by alphabetical order to next mark
    -- `[           Jump by alphabetical order to prev mark
    -- ']           Jump by alphabetical order to start of next line having a mark
    -- '[           Jump by alphabetical order to start of prev line having a mark
    -- m/           Open location list and display marks from current buffer

    -- m[0-9]       Toggle the corresponding marker !@#$%^&*()
    -- m<S-[0-9]>   Remove all markers of the same type
    -- ]-           Jump to next line having a marker of the same type
    -- [-           Jump to prev line having a marker of the same type
    -- ]=           Jump to next line having a marker of any type
    -- [=           Jump to prev line having a marker of any type
    -- m?           Open location list and display markers from current buffer
    -- m<BS>        Remove all markers
  },
  {
    "heavenshell/vim-pydocstring"
  },
  {
    "folke/tokyonight.nvim"
  },
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
