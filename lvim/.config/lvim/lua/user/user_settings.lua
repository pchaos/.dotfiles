-- 用户自定义
-- Last Modified: 2022-07-07 11:32:34
vim.opt.encoding = "utf-8"

-- White characters
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.formatoptions = 'qnj1' -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word

-- Sidebar
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.numberwidth = 3 -- set number column width to 2 {default 4}

vim.opt.updatetime = 2000 -- faster completion (4000ms default)
vim.opt.wrap = true -- line wrap

-- vim.lsp.buf.formatting_sync(nil, 3500) -- 2.5 seconds
-- vim.lsp.buf.format({ timeout_ms = 2000 }) -- nvim 0.8+

-- mapping
vim.cmd('noremap <C-b> :noh<cr>:call clearmatches()<cr>') -- clear matches Ctrl+b

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- sane regexes
nmap('/', '/\\v')
vmap('/', '/\\v')

-- keep search matches in the middle of the window
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Terminal
-- ESC to go to normal mode in terminal
tmap('<C-s>', '<C-\\><C-n>')
tmap('<Esc><Esc>', '<C-\\><C-n>')

-- edit
-- nmap('<leader>bd', ":bd<cr>") -- buffer delete
nmap('<leader>fs', ':w<cr>') -- file save 
imap('<Esc>', '<Esc>`^') -- ESC in inser mode ,todo: 行尾的时候不切换到下一行
