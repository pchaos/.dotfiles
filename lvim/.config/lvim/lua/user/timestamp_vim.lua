-- local status_ok, timestamp = pcall(require, 'timestamp.vim')
-- if not status_ok then
--   print("timestamp not loaded!", status_ok, timestamp)
--   return
-- end
-- Modified: 2025-06-19 00:12:29
-- timestamp config
vim.cmd("let g:timestamp_modelines = 6") -- set max lines to replace(default: 5)
vim.cmd("let g:timestamp_enabled = 1") -- timestamp enabled

-- insert timestamp
nmap("t<F3>", 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>')
imap('t<F3>', '<C-R>=strftime("%Y-%m-%d %a %I:% %p")<CR>')
