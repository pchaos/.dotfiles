-- Created: 2023-05-13 23:31:20
-- Modified: 2024-03-01 17:05:10
-- builtin debug 增加Last Exit
lvim.builtin.which_key.mappings.d["l"] = { "<cmd>lua require'dap'.run_last()<cr>", "Last" }
lvim.builtin.which_key.mappings.d["x"] = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" }

lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

-- builtin Diff current buffer and the original file
lvim.builtin.which_key.mappings.b["d"] = { ":w !diff % -<cr>", "Diff current buffer and the original file" }

lvim.builtin.which_key.mappings["W"] = { ":w !sudo tee %<cr>", "sudo save file" }

-- local status_ok, which_key = pcall(require, "which-key")
-- if not status_ok then
--   return
-- end

-- local m_opts = {
--   mode = "n", -- NORMAL mode
--   prefix = "<leader>m",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = true, -- use `nowait` when creating keymaps
--   desc = "Bookmarks",
-- }

-- local m_mappings = {
--   a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
--   c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
--   b = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
--   m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
--   ["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
--   [","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
--   l = { "<cmd>lua require('user.bfs').open()<cr>", "Buffers" },
--   j = { "<cmd>silent BookmarkNext<cr>", "Next" },
--   s = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },
--   k = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
--   S = { "<cmd>silent BookmarkShowAll<cr>", "Show all" },
--   -- s = {
--   --   "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
--   --   "Show",
--   -- },
--   x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
--   [";"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
-- }

-- which_key.register(m_mappings, m_opts)
