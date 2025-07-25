-- local status_ok, _ = pcall(require, "vim-bookmarks")
-- if not status_ok then
--   print("vim_bookmarks not found")
--   return
-- end
local M = {}
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("which-key not found")
  return
end

local m_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>m",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
  desc = "+Bookmarks",
}

local m_mappings = {
  a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
  c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
  b = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
  l = { "<cmd>lua require('user.bfs').open()<cr>", "Buffers" },
  j = { "<cmd>silent BookmarkNext<cr>", "Next" },
  k = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
  S = { "<cmd>silent BookmarkShowAll<cr>", "Show all" },
  -- s = {
  --   "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
  --   "Show",
  -- },
  x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
  -- [";"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
}

function M.setup()
  -- vim.g.bookmark_no_default_key_mappings = 1
  which_key.register(m_mappings, m_opts)
  which_key.register(m1_mappings, m_opts)
end

return M
