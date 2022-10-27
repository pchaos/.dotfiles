local status_ok, _ = pcall(require, 'timestamp.vim.substitute')
if not status_ok then
  print("timestamp not loaded!", status_ok)
  return
end

-- timestamp config

vim.cmd("let g:timestamp_modelines = 6") -- set max lines to replace(default: 5)
vim.cmd("let g:timestamp_enabled = 1") -- timestamp enabled
