-- 用户自定义
-- Last Modified: 2023-05-24 16:30:28

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd            -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local fn = vim.fn              -- call Vim functions
local g = vim.g                -- global variables
local opt = vim.opt            -- global/buffer/windows-scoped options

opt.encoding = "utf-8"

-- White characters
opt.expandtab = true -- expand tab to spaces
opt.formatoptions =
'qnj1'               -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word

-- Sidebar
opt.relativenumber = true
opt.showcmd = true
opt.numberwidth = 3  -- set number column width to 2 {default 4}

opt.updatetime = 300 -- faster completion (4000ms default)
opt.wrap = true      -- line wrap

vim.wo.colorcolumn = '120'

-- vim.lsp.buf.formatting_sync(nil, 3500) -- 2.5 seconds
-- vim.lsp.buf.format({ timeout_ms = 2000 }) -- nvim 0.8+

-- opt.pydocstring_doq_path = "~/.local/bin/doq"
-- lvim.pydocstring_doq_path = "~/.local/bin/doq"

cmd("let g:python3_host_prog  = expand('~/software/python3rd/anaconda/bin/python')")
cmd("let g:pydocstring_doq_path = '~/.local/bin/doq'")

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "arduino",
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
  "ini",
  "java",
  "javascript",
  "json",
  "jsonc",
  "make",
  "latex",
  "lua",
  "org",
  "pascal",
  "python",
  "regex",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}
