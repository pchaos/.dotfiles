-- Last Modified: 2024-02-23 17:27:12
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local M = {}
-- disable netrw at the very start of your init.lua

function M.setup()
  vim.g.loaded_netrw = 0
  vim.g.loaded_netrwPlugin = 0

  -- optionally enable 24-bit colour
  vim.opt.termguicolors = true

  -- empty setup using defaults
  require("nvim-tree").setup()

  -- OR setup with some options
  require("nvim-tree").setup({
    sort = { sorter = "case_sensitive" },
    view = { width = 30 },
    renderer = { group_empty = true },
    filters = { dotfiles = true },
  })
end

return M
