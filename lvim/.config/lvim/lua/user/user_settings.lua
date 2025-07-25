-- 用户自定义设置
-- Last Modified: 2025-07-25 00:29:11
-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd -- execute Vim commands
-- local exec = vim.api.nvim_exec -- execute Vimscript
local fn = vim.fn -- call Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
local api = vim.api

opt.encoding = "utf-8"
opt.fileencodings = "ucs-bom,utf-8,chinese" -- 识别中文GB2312，UTF-8

local func = require("user.functions")

-- White characters
opt.expandtab = true -- expand tab to spaces
opt.formatoptions = "qnj1" -- q - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
-- Sidebar
opt.relativenumber = true
opt.showcmd = true
opt.numberwidth = 4 -- set number column width to 3 {default 4}

-- function is_lua_file()
--   return vim.bo.filetype == "lua"
-- end

opt.updatetime = 400 -- faster completion (4000ms default)
opt.wrap = true -- line wrap

-- opt.background = "dark" -- set this to dark or light
-- lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "codemonkey"
-- lvim.colorscheme = "desert"
-- lvim.colorscheme = "evening"
lvim.colorscheme = "lunaperche"
-- lvim.colorscheme = "koehler"
-- lvim.colorscheme = "oxocarbon"

-- colored column
vim.wo.colorcolumn = "121"
-- opt.cmdheight = 2
opt.guifont = "monospace:h16" -- the font used in graphical neovim applications

g.null_ls_auto_start = 0
-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  -- python
  {
    -- The uncompromising code formatter
    command = "black",
    filetypes = { "python" },
    args = { "--line-length", "120", "--skip-string-normalization" },
  }, -- isort
  { command = "isort", filetypes = { "python" } }, --
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "120" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "latex", "typescriptreact", "css", "javascript", "markdown" },
  }, --
  {
    -- bash csh zsh
    command = "beautysh",
    filetypes = { "sh", "csh", "zsh" },
    args = { "--indent-size", "2" },
  },
  {
    -- dnf install clangd clang-tools-extra -y
    command = "clang-format",
    filetypes = { "c", "cpp" },
    args = { "--style=file" }, -- 使用项目中的 .clang-format 文件
    stdin = true,
  },
  {
    -- https://github.com/Koihik/LuaFormatter
    -- config demo: https://github.com/Koihik/LuaFormatter/blob/master/docs/Style-Config.md
    -- 针对Lua文件添加一个格式化器
    -- dnf install -y lua-devel
    command = "lua-format",
    filetypes = { "lua" },
    -- args = {"--indent-size", "2",},
    args = { "--indent-size", "2", "--extra-sep-at-table-end" },
    stdin = true,
  },
  -- {
  -- 	command = "stylua",
  -- 	filetypes = { "lua" },
  -- 	-- args = {"--indent-size", "2",},
  -- 	args = { "--indent-width", "2", "--column-width", "120" },
  -- 	stdin = true,
  -- },
})

-- vim.lsp.buf.formatting_sync(nil, 3500) -- 2.5 seconds
-- vim.lsp.buf.format({ timeout_ms = 2000 }) -- nvim 0.8+

-- lvim.pydocstring_doq_path = "~/.local/bin/doq"
-- cmd("let g:python3_host_prog  = expand('~/software/python3rd/conda3/bin/python')")
func.setGlobalVarPath("python", "python3_host_prog")

-- cmd("let g:pydocstring_doq_path = expand('~/.local/bin/doq')")
func.setGlobalVarPath("doq", "pydocstring_doq_path")

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  -- "arduino",
  "awk",
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "fish",
  "go",
  "html",
  "http",
  "ini",
  "java",
  "javascript",
  "json",
  "jsonc",
  "make",
  "latex",
  "llvm",
  "lua",
  "org",
  "pascal",
  "python",
  "regex",
  "rust",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.telescope.defaults.file_ignore_patterns = {
  "vendor/*",
  "%.lock",
  "__pycache__/*",
  "%.sqlite3",
  "%.ipynb",
  "node_modules/*",
  "%.jpg",
  "%.jpeg",
  "%.png",
  "%.svg",
  "%.otf",
  "%.ttf",
  "%.webp",
  ".dart_tool/",
  ".github/",
  ".gradle/",
  ".idea/",
  ".vscode/",
  "__pycache__/",
  "build/",
  "env/",
  "gradle/",
  "node_modules/",
  "target/",
  "%.pdb",
  "%.dll",
  "%.class",
  "%.exe",
  "%.cache",
  "%.ico",
  "%.pdf",
  "%.dylib",
  "%.jar",
  "%.docx",
  "%.met",
  "smalljre_*/*",
  ".vale/",
}

-- require("user.plugins.auto-update-timestamp").config()
-- require("user.plugins.auto-update-timestamp").set_ignore_file_name("tmp.txt")
local ok, auto_update_timestamp = pcall(require, "user.plugins.auto-update-timestamp")
if ok then
  auto_update_timestamp.config()
  auto_update_timestamp.set_ignore_file_name("tnp.txt")
else
  vim.notify("Failed to load plugin module auto-update-timestamp", vim.log.levels.WARN)
end

-- require('user.plugins.luasnip_config').setup()
-- require("user.plugins.friendly-snippets").setup()
