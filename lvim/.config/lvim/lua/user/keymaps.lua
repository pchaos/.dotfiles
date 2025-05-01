-- Modified: 2025-05-01 12:01:55
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

local cmd = vim.cmd -- execute Vim commands

-- insert timestamp
-- nmap("<F3>", 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>')
-- imap('<F3>', '<C-R>=strftime("%Y-%m-%d %a %I:% %p")<CR>')

-- sane regexes
nmap('/', '/\\v')
vmap('/', '/\\v')

-- keep search matches in the middle of the window
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Centers cursor when moving 1/2 page down
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"

-- Terminal
-- ESC to go to normal mode in terminal
tmap('<C-s>', '<C-\\><C-n>')
tmap('<Esc><Esc>', '<C-\\><C-n>')

-- edit
-- nmap('<leader>bd', ":bd<cr>") -- buffer delete
-- nmap('<leader>fs', ':w<cr>')  -- file save
imap('<Esc>', '<Esc>`^') -- ESC in inser mode ,todo: 行尾的时候不切换到下一行

-- Convert Inserted Text to Normal Mode Commands
imap('<F2>', '<ESC>u@.')

cmd('noremap <C-b> :noh<cr>:call clearmatches()<cr>') -- clear matches Ctrl+b

-- tab move
-- nmap('S-h', ':bnext<cr>')
-- nmap('S-l', ':bprev<cr>')
lvim.keys.normal_mode["<A-l>"] = ":bnext<cr>" -- alt+l move to next tab
lvim.keys.normal_mode["<A-h>"] = ":bprev<cr>" -- alt+h move to prev tab

-- <C--> 快捷键来触发 pydocstring 插件
lvim.keys.normal_mode["<C-->"] = { "<Plug>(pydocstring)", { silent = true } }

-- ge to use it beyond just URLs! 默认的gx不起作用；使用ge快捷键替换默认设置
lvim.keys.normal_mode['ge'] = { '<Plug>(gxext-normal)', { silent = false } }
lvim.keys.visual_mode['ge'] = { '<Plug>(gxext-visual)', { silent = false } }
-- nmap("gx", "<Plug>(gxext-normal)")
-- vmap("gx", "<Plug>(gxext-vi

-- keybindings for python unittest
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dM"] = {
  "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP",
}

lvim.builtin.which_key.mappings["df"] =
  { "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
  "Test Class DAP",
}

-- local delete_empty_lines = require('user.functions').delete_empty_lines
lvim.builtin.which_key.mappings["bx"] = {
  -- :g/^\s*$\n\s*$/d 只有回车的空行，还能删除包含tab键和空格的空行
  -- ":g/^\\s*$\\n\\s*$/d<CR>",
  -- ":lua delete_empty_lines()<CR>",
  ":lua require('user.functions').delete_empty_lines ()<CR>",
  "连续的多个空行删除为只留一下一个空行",
}

lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

-- django-keymmaps
-- require("user.keymaps.django-keymmaps")

local status_ok, vb = pcall(require, "user.keymaps.vim-bookmarks-keymaps")
if status_ok then
  vb.setup()
end

local status_ok, ts = pcall(require, "user.keymaps.telescope-keymaps")
if status_ok then
  ts.setup()
end
