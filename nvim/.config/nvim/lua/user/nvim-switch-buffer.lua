-- Use a protected call so we don't error out on first use
local status_ok, _ = pcall(require, "nvim-switch-buffer")
if not status_ok then
	return
end

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

nmap('S', ':SwitchBuffer <cr>')

vim.opt.switchbuf = "usetab"
