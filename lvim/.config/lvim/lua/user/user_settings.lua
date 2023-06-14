-- 用户自定义
-- Last Modified: 2023-06-14 10:25:56
-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local fn = vim.fn -- call Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options

opt.encoding = "utf-8"

-- White characters
opt.expandtab = true -- expand tab to spaces
opt.formatoptions = 'qnj1' -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word

-- Sidebar
opt.relativenumber = true
opt.showcmd = true
opt.numberwidth = 3 -- set number column width to 3 {default 4}

-- lua文件设置保存格式化代码tab为四个空格
-- lvim.augroups = {
--   _general_settings = {
--     -- 设置 lua 文件缩进
--     { "FileType", "lua", "setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab" },
--   },
-- }

-- function is_lua_file()
--   return vim.bo.filetype == "lua"
-- end

opt.updatetime = 350 -- faster completion (4000ms default)
opt.wrap = true -- line wrap

-- colored column
vim.wo.colorcolumn = '120'

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    -- python
    {command = "black", filetypes = {"python"}}, {command = "isort", filetypes = {"python"}}, -- 
    {
        -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        command = "prettier",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
        extra_args = {"--print-with", "100"},
        ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = {"typescript", "typescriptreact"}
    }, -- 
    {
        -- 针对Lua文件添加一个格式化器（lua-langage-server）
        -- dnf install -y lua-devle  
        command = "lua-format",
        filetypes = {"lua"},
        args = {
            "--indent-width", "4", "--tab-width", "4", "--no-use-tab", "--column-limit=120",
            "--no-keep-simple-control-block-one-line"
        },
        stdin = true
    }
}

-- vim.lsp.buf.formatting_sync(nil, 3500) -- 2.5 seconds
-- vim.lsp.buf.format({ timeout_ms = 2000 }) -- nvim 0.8+

-- opt.pydocstring_doq_path = "~/.local/bin/doq"
-- lvim.pydocstring_doq_path = "~/.local/bin/doq"
cmd("let g:python3_host_prog  = expand('~/software/python3rd/anaconda/bin/python')")
cmd("let g:pydocstring_doq_path = '~/.local/bin/doq'")

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "arduino", "bash", "c", "cmake", "cpp", "css", "diff", "dockerfile", "fish", "go", "html", "ini", "java",
    "javascript", "json", "jsonc", "make", "latex", "lua", "org", "pascal", "python", "regex", "rust", "toml", "tsx",
    "typescript", "vim", "vimdoc", "yaml"
}
lvim.builtin.treesitter.ignore_install = {"haskell"}
lvim.builtin.treesitter.highlight.enabled = true
