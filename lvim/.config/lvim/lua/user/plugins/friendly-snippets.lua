-- Last Modified: 2024-03-10 14:18:30
local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end

local M = {}
function M.test()
  print("test friendly=snippets")
  print(vim.cmd("pwd"))
end

function M.print_current_directory()
  local current_dir = vim.fn.getcwd()
  print("当前工作目录：" .. current_dir)
end

function M.setup()
  -- require("friendly-snippets").setup()
  require("luasnip.loaders.from_vscode").load({ paths = { "/home/user/.dotfiles/lvim/.config/lvim/snippets" } })
end

-- require("luasnip.loaders.from_vscode").load { exclude = { "typescript" } }
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
return M
