-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

vim.g.vscode_snippets_path = vim.fn.stdpath "config" .. "/snippets"
print("vscode_snippets_path: " .. vim.g.vscode_snippets_path)
require("luasnip.loaders.from_vscode").load()
require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path }

-- require()
-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

-- Last Modified: TIMESTAMP
return M
