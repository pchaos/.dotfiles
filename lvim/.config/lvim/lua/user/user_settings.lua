-- 用户自定义
-- Last Modified: 2023-06-15 12:30:02
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

-- function is_lua_file()
--   return vim.bo.filetype == "lua"
-- end

opt.updatetime = 350 -- faster completion (4000ms default)
opt.wrap = true -- line wrap

-- colored column
vim.wo.colorcolumn = '121'

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    -- python
    {command = "black", filetypes = {"python"}}, -- 
    {command = "isort", filetypes = {"python"}}, -- 
    {
        -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        command = "prettier",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
        extra_args = {"--print-with", "120"},
        ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = {"typescript", "typescriptreact", "markdown"}
    }, -- 
    {command = "beautysh", filetypes = {"sh", "csh", "zsh"}, args = {"--indent-size", "2"}}, -- bash csh zsh
    {
        -- https://github.com/Koihik/LuaFormatter 
        -- 针对Lua文件添加一个格式化器
        -- dnf install -y lua-devel  
        command = "lua-format",
        filetypes = {"lua"},
        args = {"--indent-size", "2"},
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
