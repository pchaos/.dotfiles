-- Install your plugins here
lvim.plugins = {
  -- Last modified:   2024-04-29 12:08:19

  -- {
  --   "felipec/vim-sanegx",
  --   -- open url with gx
  --   event = "BufRead",
  -- },
  {
    -- https://wakatime.com/dashboard
    'wakatime/vim-wakatime',
  },
  {
    -- A vim / nvim plugin that intelligently reopens files at your last edit position.
    "farmergreg/vim-lastplace",
    config = function()
      vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
      vim.g.lastplace_ignore_buftype = "quickfix,nofile,help"
    end,
  },
  {
    -- https://github.com/nathom/filetype.nvim
    "nathom/filetype.nvim",
    lazy = true,
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("filetype").setup({ overrides = { extensions = { h = "cpp" } } })
    end,
  },
  {
    --[[
    https://github.com/declancm/windex.nvim
    A neovim plugin for cleeean neovim window (and tmux pane) functions
    Use <leader>z to toggle maximizing the current neovim window (without any of the ugly borders that other maximizing plugins create) AND the current tmux pane.
    -- ]]
    'declancm/windex.nvim',
    config = function()
      require('windex').setup()
    end,
  },
  -- {
  --   "s1n7ax/nvim-window-picker",
  --   -- lazy = true,
  --   event = { "WinNew" },
  --   dependencies = { "ten3roberts/window-picker.nvim" },
  --   config = function()
  --     local picker = require("window-picker")
  --     picker.setup({
  --       autoselect_one = true,
  --       include_current = false,
  --       filter_rules = {
  --         bo = { filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" }, buftype = { "terminal" } },
  --       },
  --       other_win_hl_color = "#e35e4f",
  --     })

  --     --  以下快捷键设置，转换成lunarvim语法
  --     vim.keymap.set("n", ",r", function()
  --       local picked_window_id = picker.pick_window({ include_current_win = true }) or vim.api.nvim_get_current_win()
  --       vim.api.nvim_set_current_win(picked_window_id)
  --     end, { desc = "Pick a window" })

  --     -- Swap two windows using the awesome window picker
  --     local function swap_windows()
  --       local window = picker.pick_window({ include_current_win = false })
  --       local target_buffer = vim.fn.winbufnr(window)
  --       -- Set the target window to contain current buffer
  --       vim.api.nvim_win_set_buf(window, 0)
  --       -- Set current window to contain target buffer
  --       vim.api.nvim_win_set_buf(0, target_buffer)
  --     end

  --     vim.keymap.set("n", ",W", swap_windows, { desc = "Swap windows" })
  --   end,
  -- },

  -- {
  --   -- https://github.com/ten3roberts/window-picker.nvim
  --   "ten3roberts/window-picker.nvim",
  --   event = { "WinNew", "TabNew", "FileReadPost " },
  --   config = function()
  --     require'window-picker'.setup {
  --       -- Default keys to annotate, keys will be used in order. The default uses the
  --       -- most accessible keys from the home row and then top row.
  --       keys = 'alskdjfhgwoeiruty',
  --       -- Swap windows by holding shift + letter
  --       swap_shift = true,
  --       -- Windows containing filetype to exclude
  --       exclude = { qf = true, NvimTree = true, aerial = true },
  --       -- Flash the cursor line of the newly focused window for 300ms.
  --       -- Set to 0 or false to disable.
  --       flash_duration = 300,
  --     }
  --     -- Example keymaps
  --     -- Move to window, or swap by using shift + letter
  --     lvim.keymap.normal_mode[",w"] = "WindowPick"

  --     -- Swap with any window
  --     lvim.keymap.normal_mode[",W"] = "WindowSwap"
  --     lvim.keymap.normal_mode[",q"] = "WindowZap"
  --   end,
  -- },

  {
    "iamcco/markdown-preview.nvim",
    event = { "BufRead" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      -- " set to 1, nvim will open the preview window after entering the markdown buffer
      -- " default: 0
      vim.g.mkdp_auto_start = 0
    end,

  }, -- {
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
  {
    -- A highly customizable theme for vim and neovim with support for lsp, treesitter and a variety of plugins.
    "EdenEast/nightfox.nvim",
  },
  {
    -- https://github.com/ap/vim-css-color
    "ap/vim-css-color",
    ft = { "css" },
  },
  -- {
  --   -- 还没配置好
  --   -- A vim theme scheduler. Divide your day into as many intervals as you like, assigning each interval its own theme.

  --   -- https://github.com/erwinvaneijk/night-and-day
  --   "erwinvaneijk/night-and-day",
  --   -- config = function()
  --   --   vim.g.nd_themes = {
  --   --     { '4:00', 'peachpuff', 'light' },
  --   --     { '11:00', 'murphy', 'dark' },
  --   --     { '18:00', 'evening', 'dark' },
  --   --   }
  --   -- end,
  -- },
  -- {
  --  -- 需要配置lazy=false,否则不会显示TokyoNight
  --   -- https://github.com/folke/tokyonight.nvim
  --   -- A dark and light Neovim theme written in Lua ported from the Visual Studio Code TokyoNight theme. Includes extra themes for Kitty, Alacritty, iTerm and Fish.
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  -- },
  -- {
  -- -- 可能引起查找文件时卡死？？？
  --     "nyoom-engineering/oxocarbon.nvim",
  -- },
  {
    --[[
    https://github.com/MattesGroeger/vim-bookmarks/issues
    This vim plugin allows toggling bookmarks per line. A quickfix window gives access to all bookmarks. Annotations can be added as well. These are special bookmarks with a comment attached. They are useful for preparing code reviews. All bookmarks will be restored on the next startup.
    --]]
    "MattesGroeger/vim-bookmarks",
    init = function()
      vim.g.bookmark_no_default_key_mappings = 1
      vim.g.bookmark_auto_save = 1 -- Enables/disables automatic saving for bookmarks
    end,
  },
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
    lazy = true,
    -- ds : 删除包围符号
    -- cs : 改变包围符号
    -- ysw : 当前至下一个词尾添加一个包围符号
    -- ysW : 当前至至下一个空格添加一个包围符号
    -- ySw : 当前至下一个词尾添加一个包围符号并将焦点移至下一行
    -- ySW : 当前至下一个空格添加一个包围符号并将焦点移至下一行
    -- yss : 整行添加包围符号
    -- S": Visual 模式下对选中区域添加包围符号 "
    -- gS": Visual 模式下对选中区域进行换行并添加包围符号
    -- ⌃-s : Insert 模式下插入包围符号
    -- ⌃-s, ⌃-s : Insert 模式下在插入包围符号并将焦点移至下一行
    -- dst : 删除 html/xml 的标签内部的所有字符
    -- cst : 删除 html/xml 的标签内部的所有字符并进入插入模式
    -- ysa<': 在 <> 包裹的范围上加符号 '
  },
  { -- 支持重复
    "tpope/vim-repeat",
    event = "BufRead",
  },
  {
    -- Signify (or just Sy) uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system (VCS).
    "mhinz/vim-signify",
    lazy = true,
  }, -- {
  --   "ggandor/leap.nvim",
  --   -- Leap is a general-purpose motion plugin for Neovim, with the ultimate goal of establishing a new standard interface for moving around in the visible area in Vim-like modal editors.
  --   -- Leap allows you to jump to any positions in the visible editor area by entering a 2-character search pattern, and then potentially a label character to pick your target from multiple matches, similar to Sneak. The novel idea in Leap is its "clairvoyant" ability: you get a live preview of the target labels - by mapping possible futures, Leap can show you which key(s) you will need to press before you actually need to do that.
  --   name = "leap",
  --   config = function()
  --     require("leap").add_default_mappings()
  --   end,
  -- },
  {
    -- o vim-signature is a plugin to place, toggle and display marks.
    "kshenoy/vim-signature",
    lazy = true,
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
    -- A vim 7.4+ plugin to generate table of contents for Markdown files.
    -- Generate table of contents
    -- Move the cursor to the line you want to append table of contents, then type a command below suit you. The command will generate headings after the cursor into table of contents.
    -- :GenTocGFM
    -- Generate table of contents in GFM link style.
    -- This command is suitable for Markdown files in GitHub repositories, like README.md, and Markdown files for GitBook.
    -- :GenTocRedcarpet
    -- Generate table of contents in Redcarpet link style.
    -- This command is suitable for Jekyll or anywhere else use Redcarpet as its Markdown parser.
    -- :GenTocGitLab
    -- Generate table of contents in GitLab link style.
    -- This command is suitable for GitLab repository and wiki.
    -- :GenTocMarked
    -- Generate table of contents for iamcco/markdown-preview.vim which use Marked markdown parser.
    -- Update existing table of contents
    -- Generally you don't need to do this manually, existing table of contents will auto update on save by default.

    -- The :UpdateToc command, which is designed to update toc manually, can only work when g:vmt_auto_update_on_save turned off, and keep insert fence.

    -- Remove table of contents
    -- :RemoveToc command will do this for you, just remember keep insert fence option by default.

    'mzlogin/vim-markdown-toc',
  },
  {
    -- https://github.com/fidian/hexmode
    "fidian/hexmode",
  },
  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-dap-python", ft = { "python" } }, -- {
  --   'jpalardy/vim-slime',
  --   ft = { "python" },
  -- },
  -- {
  --  'hanschen/vim-ipython-cell',
  --   ft = { "python" },
  -- },
  {
    "heavenshell/vim-pydocstring",
    ft = { "python" },
    lazy = true,
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
    -- https://github.com/vim-test/vim-test
    --[[
    Python
Since there are multiple Python test runners for the same type of tests, test.vim has no way of detecting which one did you intend to use. By default the first available will be chosen, but you can force a specific one:

let test#python#runner = 'pytest'
" Runners available are 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose', 'mamba', and Python's built-in unittest as 'pyunit'
--]]
    "vim-test/vim-test",
    ft = { "python", "lua" },
  },
  {
    -- https://github.com/stevearc/dressing.nvim
    "stevearc/dressing.nvim",
    lazy = true,
  },
  {
    -- Managing Virtual Environments
    "AckslD/swenv.nvim",
    lazy = true,
    config = function()
      require('swenv').setup({
        -- Should return a list of tables with a `name` and a `path` entry each.
        -- Gets the argument `venvs_path` set below.
        -- By default just lists the entries in `venvs_path`.
        get_venvs = function(venvs_path)
          return require('swenv.api').get_venvs(venvs_path)
        end,
        -- Path passed to `get_venvs`.
        venvs_path = vim.fn.expand('~/software/python3rd/conda3/bin'),
        -- Something to do after setting an environment, for example call vim.cmd.LspRestart
        post_set_venv = vim.cmd.LspRestart,
      })
    end,

  },
  {
    -- https://github.com/stsewd/gx-extended.vim
    -- If you have plasticboy/vim-markdown installed (it's included in sheerun/vim-polyglot) you'll need to disable the default key mappings, since that plugin remaps gx by default.
    'stsewd/gx-extended.vim',
    -- lazy = true,
    -- Extend gx to use it beyond just URLs!
    -- using shortcut: ge
  },
  {
    -- An awesome automatic table creator & formatter allowing one to create neat tables as you type.
    -- https://github.com/dhruvasagar/vim-table-mode
    "dhruvasagar/vim-table-mode",
    -- lazy = true,
  },
  -- {
  --   -- Python-mode, a Python IDE for Vim
  --   "python-mode/python-mode",
  --   branch = "develop",
  -- },
  -- { "Glench/Vim-Jinja2-Syntax" },
  -- { "PegasusWang/vim-ubuntu-pastebin" },
  -- {
  --   -- https://github.com/iurimateus/luasnip-latex-snippets.nvim
  --   -- A port of Gilles Castel's snippets for the LuaSnip Engine.
  --   "iurimateus/luasnip-latex-snippets.nvim",
  --   ft = { "markdown", "latex" },
  --   config = function()
  --     require("luasnip-latex-snippets").setup()
  --     -- require("luasnip.config").set_config { enable_autosnippets = true }
  --     -- require("luasnip").config.setup { enable_autosnippets = true }
  --     require("luasnip").config.setup { enable_autosnippets = true, use_treesitter = true, allow_on_markdown = true }
  --     -- require("luasnip").config.setup { enable_autosnippets = false, use_treesitter = true, allow_on_markdown = true }
  --   end,
  --   dependencies = { { "L3MON4D3/LuaSnip" }, { "lervag/vimtex" } },
  -- },
  {
    --[[ https://github.com/Exafunction/codeium.vim
| Action | Function | Default Binding |
| --- | --- | --- |
| Clear current suggestion | `codeium#Clear()` | `<C-]>` |
| Next suggestion | `codeium#CycleCompletions(1)` | `<M-]>` |
| Previous suggestion | `codeium#CycleCompletions(-1)` | `<M-[>` |
| Insert suggestion | `codeium#Accept()` | `<Tab>` |
| Manually trigger suggestion | `codeium#Complete()` | `<M-Bslash>` |
      --]]
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-;>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-,>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true })
    end,
  },
  {
    "pchaos/timestamp.vim",
    -- branch = "master",
    branch = "dev",
    event = { "BufWritePre" },
    lazy = true,
    -- When a file is written, and the filename matches |timestamp_automask|, this plugin will search the first and last |timestamp_modelines| lines of your file. If it finds the regexp |timestamp_regexp| then it will replace it with a timestamp. The timestamp is computed by first doing a |token_substitution| on |timestamp_rep| and passing the result to |strftime()|.
    -- For instance, if you create a new file and want to stamp it with a creation date and a last modified date, make the first few lines: >
    --    Created:            TIMESTAMP
    --    Last modified:      TIMESTAMP
    --    Modified:      TIMESTAMP
    --    Changed:       TIMESTAMP
  },
  { -- 返回到 normal 模式时快速切换为英文输入法
    "pchaos/fcitx5-status",
    -- branch = "dev",

  },
  { "pchaos/vim-templates", event = { "BufNewFile" } },
  -- { "pchaos/vim-templates" },
  { "pchaos/vim-lua-formatter.nvim", branch = "dev", ft = { "lua" } },
  -- {
  --   "pchaos/select2snippet"
  -- },
  -- {
  --   -- 加载copilot后，vim比较卡
  --   "github/copilot.vim",
  --   ft = { "python", "lua" },
  --   lazy = true,
  -- },
  -- {
  --   "nvim-neotest/neotest",
  --   ft = { "python", "c", "lua" },
  --   dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "antoinemadec/FixCursorHold.nvim" },
  -- },
  -- {
  --   "nvim-neotest/neotest-python",
  --   ft = { "python" },
  --   config = function()
  --     require("neotest").setup({
  --       adapters = {
  --         require("neotest-python")({
  --           -- Extra arguments for nvim-dap configuration
  --           -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
  --           dap = { justMyCode = false, console = "integratedTerminal" },
  --           -- Command line arguments for runner
  --           -- Can also be a function to return dynamic values
  --           args = { "--log-level", "DEBUG" },
  --           -- Runner to use. Will use pytest if available by default.
  --           -- Can be a function to return dynamic value.
  --           runner = "pytest",
  --           -- Custom python path for the runner.
  --           --       -- Can be a string or a list of strings.
  --           --       -- Can also be a function to return dynamic value.
  --           --       -- If not provided, the path will be inferred by checking for
  --           --       -- virtual envs in the local directory and for Pipenev/Poetry configs
  --           --       -- python = ".venv/bin/python",
  --           --       -- Returns if a given file path is a test file.
  --           --       -- NB: This function is called a lot so don't perform any heavy tasks within it.
  --           --       -- is_test_file = function(file_path)
  --           --       -- end,
  --         }),
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "nvim-neotest/neotest-plenary",
  --   config = function()
  --     require("neotest").setup({ adapters = { require("neotest-plenary") } })
  --   end,
  -- },
}
