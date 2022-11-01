-- local status_ok, timestamp = pcall(require, 'timestamp.vim')
-- if not status_ok then
--   print("timestamp not loaded!", status_ok, timestamp)
--   return
-- end
-- Modified: 2022-10-26 14:23:10

-- timestamp config

vim.cmd("let g:timestamp_modelines = 6") -- set max lines to replace(default: 5)
vim.cmd("let g:timestamp_enabled = 1") -- timestamp enabled

-- insert timestamp
nmap("<F3>", 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>')
imap('<F3>', '<C-R>=strftime("%Y-%m-%d %a %I:% %p")<CR>')
