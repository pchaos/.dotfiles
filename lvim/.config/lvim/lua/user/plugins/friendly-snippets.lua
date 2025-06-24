-- Last Modified: 2025-06-19 11:49:57
local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end

local M = {}
function M.test()
  print("test friendly-snippets")
  print(vim.cmd("pwd"))
end

function M.print_current_directory()
  local current_dir = vim.fn.getcwd()
  print("当前工作目录：" .. current_dir)
end

function M.setup()
  require("luasnip").config.setup({
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
  })
  require("luasnip.loaders.from_vscode").lazy_load()
  -- require("friendly-snippets").setup()
  -- require("luasnip.loaders.from_vscode").load({ paths = { "/home/user/.dotfiles/lvim/.config/lvim/snippets" } })
  -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { os.getenv("HOME") .. "/.config/lvim/snippets" } })
  require("luasnip.loaders.from_vscode").lazy_load({ paths = os.getenv("HOME") .. "/.config/lvim/snippets" })
  lvim.builtin.luasnip = {
    sources = {
      friendly_snippets = true, -- 启用官方片段
      lvim = true, -- 加载 LunarVim 内置片段
      custom = { -- 加载自定义片段
        { path = os.getenv("HOME") .. "/.config/lvim/snippets" },
      },
    },
  }
end

-- require("luasnip.loaders.from_vscode").load { exclude = { "typescript" } }
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
return M
