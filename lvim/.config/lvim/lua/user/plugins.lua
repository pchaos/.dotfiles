--4Install your plugins here
lvim.plugins = {
  -- Last modified:   2023-06-24 13:34:07

  -- {
  --   "felipec/vim-sanegx",
  --   -- open url with gx
  --   event = "BufRead",
  -- },

  {
    "iamcco/markdown-preview.nvim",
    event = "BufRead",
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   run = "cd app && npm install",
  --   -- run = function() vim.fn["mkdp#util#install"]() end,
  --   setup = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = "markdown",
  --   config = function()
  --     -- " set to 1, nvim will open the preview window after entering the markdown buffer
  --     -- " default: 0
  --     vim.g.mkdp_auto_start = 0
  --   end,
  -- },
  -- {
  --   "LunarVim/Colorschemes"
  -- },
  -- {
    -- -- 可能引起查找文件时卡死？？？
  --     "nyoom-engineering/oxocarbon.nvim",
  -- },
  {
    -- Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.
    -- https://github.com/tpope/vim-surround/blob/master/doc/surround.txt
    -- 使用该插件可以很方便的添加包围符号：

    -- 首先进入普通模式，将光标移动到需要包围的文本块区域。
    -- 然后按下 v 进入可视模式，选中需要包围的文本块区域。
    -- 运行命令 S{your-surrounding-character}，其中 {your-surrounding-character} 表示您想要使用的自定义字符或字符串，如引号、括号等。
    -- 例如，如果您想要使用单引号将选中的文本块包围起来，可以按下 S' 键（注意是大写字母 S），然后 surround.vim 就会自动将选中的文本块用单引号包围起来。

    "tpope/vim-surround",
    event = "BufRead",
  },

  {
    "tpope/vim-repeat",
    event = "BufRead",
  },

  {
    "mhinz/vim-signify"
    --Signify (or just Sy) uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system (VCS).
  },

  -- {
  --   "ggandor/leap.nvim",
  --   -- Leap is a general-purpose motion plugin for Neovim, with the ultimate goal of establishing a new standard interface for moving around in the visible area in Vim-like modal editors.
  --   -- Leap allows you to jump to any positions in the visible editor area by entering a 2-character search pattern, and then potentially a label character to pick your target from multiple matches, similar to Sneak. The novel idea in Leap is its "clairvoyant" ability: you get a live preview of the target labels - by mapping possible futures, Leap can show you which key(s) you will need to press before you actually need to do that.
  --   name = "leap",
  --   config = function()
  --     require("leap").add_default_mappings()
  --   end,
  -- },

  {
    "kshenoy/vim-signature",
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
    "mfussenegger/nvim-dap",
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
  },
  {
    "nvim-neotest/neotest",
    ft = { "python", "c", "lua" },
    dependencies = {
      -- "nvim-lua/plenary.nvim",
      -- "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    }
  },
  {
    "nvim-neotest/neotest-python",
    ft = { "python" },
    -- https://betterprogramming.pub/lunarvim-debugging-testing-python-code-fa84f804c469
    -- require("neotest").setup({
    --   adapters = {
    --     require("neotest-python")({
    --       -- Extra arguments for nvim-dap configuration
    --       -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
    --       dap = { justMyCode = false },
    --       -- Command line arguments for runner
    --       -- Can also be a function to return dynamic values
    --       args = { "--log-level", "DEBUG" },
    --       -- Runner to use. Will use pytest if available by default.
    --       -- Can be a function to return dynamic value.
    --       runner = "pytest",
    --       -- Custom python path for the runner.
    --       -- Can be a string or a list of strings.
    --       -- Can also be a function to return dynamic value.
    --       -- If not provided, the path will be inferred by checking for
    --       -- virtual envs in the local directory and for Pipenev/Poetry configs
    --       -- python = ".venv/bin/python",
    --       -- Returns if a given file path is a test file.
    --       -- NB: This function is called a lot so don't perform any heavy tasks within it.
    --       -- is_test_file = function(file_path)
    --       -- end,
    --     })
    --   }
    -- }
    -- Set up Keybindings
    -- This section might look a little complicated but all we’re doing is adding some keybindings to our leader key menu that pops up when you press space. For instance, pressing space d m will test the nearest method.

    -- lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
    --   "Test Method" }
    -- lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
    --   "Test Method DAP" }
    -- lvim.builtin.which_key.mappings["df"] = {
    --   "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
    -- lvim.builtin.which_key.mappings["dF"] = {
    --   "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
    -- lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }
    -- Keybindings explanation:

    -- space d m: runs the nearest test
    -- space d M: runs the nearest test in debug mode
    -- space d f: runs all tests in file
    -- space d F: runs all tests in file in debug mode
    -- space d S: displays summary for tests)
  },
  {
    "heavenshell/vim-pydocstring",
    ft = { "python" },
    --     Basic usage
    -- Move your cursor on a def or class keyword line,
    -- type :Pydocstring and
    -- watch a docstring template magically appear below the current line
    -- Format all
    -- type :PydocstringFormat will insert all docstrings to current buffer.

    -- Settings
    -- Pydocstring depends on shiftwidth if smarttab is set, otherwise softtabstop. For the latter, you need to set like set softtabstop=4.

    -- Example .vimrc

    -- autocmd FileType python setlocal tabstop=4 shiftwidth=4 smarttab expandtab
    -- Or:

    -- autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    -- Pydocstring use ftplugin, so filetype plugin on required.

    -- Key map
    -- If you want change default keymapping, set following to your .vimrc.

    -- nmap <silent> <C-_> <Plug>(pydocstring)
    -- Or, if you want disable default keymapping, you can set like following.

    -- let g:pydocstring_enable_mapping = 0
  },

  {
    -- Managing Virtual Environments
    "AckslD/swenv.nvim",
    "stevearc/dressing.nvim",
    config = function()
      require('swenv').setup({
        -- Should return a list of tables with a `name` and a `path` entry each.
        -- Gets the argument `venvs_path` set below.
        -- By default just lists the entries in `venvs_path`.
        get_venvs = function(venvs_path)
          return require('swenv.api').get_venvs(venvs_path)
        end,
        -- Path passed to `get_venvs`.
        venvs_path = vim.fn.expand('~/software/python3rd/anaconda/bin'),
        -- Something to do after setting an environment, for example call vim.cmd.LspRestart
        post_set_venv = vim.cmd.LspRestart,
      })
    end

  },
  {
    'stsewd/gx-extended.vim',
    -- Extend gx to use it beyond just URLs!
    -- using shortcut: ge
  },
  {
    "dhruvasagar/vim-table-mode",
    -- https://github.com/dhruvasagar/vim-table-mode
  },
  -- {
  --   -- Python-mode, a Python IDE for Vim
  --   "python-mode/python-mode",
  --   branch = "develop",
  -- },
  {
    "Glench/Vim-Jinja2-Syntax"
  },
  {
    "pchaos/timestamp.vim",
    branch = "master",
    -- branch = "dev",
    -- When a file is written, and the filename matches |timestamp_automask|, this plugin will search the first and last |timestamp_modelines| lines of your file. If it finds the regexp |timestamp_regexp| then it will replace it with a timestamp. The timestamp is computed by first doing a |token_substitution| on |timestamp_rep| and passing the result to |strftime()|.
    -- For instance, if you create a new file and want to stamp it with a creation date and a last modified date, make the first few lines: >
    --    Created:            TIMESTAMP
    --    Last modified:      TIMESTAMP
    --    Modified:      TIMESTAMP
    --    Changed:       TIMESTAMP
  },

  {
    "pchaos/fcitx5-status"
  },
  {
    "pchaos/vim-templates"
  },
  -- {
  --   "pchaos/select2snippet"
  -- }
}

local noused_plugins = {
  {
    -- barbar.nvim is a tabline plugin with re-orderable, auto-sizing, clickable tabs, icons, nice highlighting, sort-by commands and a magic jump-to-buffer mode. Plus the tab names are made unique when two filenames match.
    'romgrk/barbar.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('barbar').setup()
    end
  },
}
