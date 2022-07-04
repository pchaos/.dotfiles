local status_ok, _ = pcall(require, 'bufferline')
if not status_ok then
	print("bufferline not loaded")
	return
end

local map = vim.api.nvim_set_keymap
vim.g.maplocalleader = "\\"
local opts = { noremap = true, silent = true }
-- local opts = { noremap = true, silent = false }

-- Move to previous/next
map('n', '<leader>,', '<Cmd>BufferLineCyclePrev<CR>', opts)
map('n', '<leader>.', '<Cmd>BufferLineCycleNext<CR>', opts)
-- Re-order to previous/next
map('n', '<leader><', '<Cmd>BufferLMovePrevious<CR>', opts)
map('n', '<leader>>', '<Cmd>BufferLastMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<leader>1', ':BufferLineGotoBuffer 1<CR>', opts)
map('n', '<leader>2', '<Cmd>BufferLineGotoBuffer 2<CR>', opts)
map('n', '<leader>3', '<Cmd>BufferLineGotoBuffer 3<CR>', opts)
map('n', '<leader>4', '<Cmd>BufferLineGotoBuffer 4<CR>', opts)
map('n', '<leader>5', '<Cmd>BufferLineGotoBuffer 5<CR>', opts)
map('n', '<leader>6', '<Cmd>BufferLineGotoBuffer 6<CR>', opts)
map('n', '<leader>7', '<Cmd>BufferLineGotoBuffer 7<CR>', opts)
map('n', '<leader>8', '<Cmd>BufferLineGotoBuffer 8<CR>', opts)
map('n', '<leader>9', '<Cmd>BufferLineGotoBuffer 9<CR>', opts)
map('n', '<leader>0', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<leader>bp', '<Cmd>bufferLineTogglePin<CR>', opts)
-- Close buffer
map('n', '<leader>c', '<Cmd>BufferLinePickClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p', '<Cmd>BufferLinePickR>', opts)
-- Sort automatically by...
map('n', '<Space>bd', '<Cmd>BufferLineSortByDirectoryCR>', opts)
map('n', '<Space>bl', '<Cmd>BufferLineSortByExtension<CR>', opts)
