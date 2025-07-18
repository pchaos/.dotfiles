-- Last Modified: 2025-07-17 21:18:02
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
  print("DEBUG: snippets M.setup() function started.")
  require("luasnip").config.setup({
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
  })
  print("DEBUG: Luasnip configuration applied.")
  -- require("friendly-snippets").setup()
  -- require("luasnip.loaders.from_vscode").lazy_load()
  -- require("luasnip.loaders.from_vscode").load({ paths = { "/home/user/.dotfiles/lvim/.config/lvim/snippets" } })
  -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { os.getenv("HOME") .. "/.config/lvim/snippets" } })
  -- require("luasnip.loaders.from_vscode").lazy_load({ paths = os.getenv("HOME") .. "/.config/lvim/snippets" })
  -- local home_dir = os.getenv("HOME")
  local home_dir = vim.fn.stdpath("config")
  print("DEBUG: HOME environment variable: " .. (home_dir or "NIL"))

  -- Debug: Path to custom snippets
  -- local custom_snippets_path = home_dir .. "/.config/lvim/snippets"
  -- local custom_snippets_path = home_dir .. "/snippets"
  local custom_snippets_path = home_dir .. "/"
  local lua_snippets_path = home_dir .. "/snippets/lua_custom_snippets.lua" -- New path
  print("DEBUG: Expected custom snippets path: " .. custom_snippets_path)
  lvim.builtin.luasnip = {
    sources = {
      friendly_snippets = true, -- 启用官方片段
      lvim = true, -- 加载 LunarVim 内置片段
      custom = { -- 加载自定义片段
        { paths = custom_snippets_path },
        -- Load your Lua dynamic snippets
        { paths = lua_snippets_path, ft_func = require("luasnip.loaders.from_lua").load },
      },
    },
  }
  print("DEBUG: Inspecting lvim.builtin.luasnip.sources.custom:")
  print(vim.inspect(lvim.builtin.luasnip.sources.custom))
  print("DEBUG: lvim.builtin.luasnip.sources configured.")
end

-- Add this to your init.lua temporarily
function M.list_snippets_debug()
  local luasnip = require("luasnip")
  local current_filetype = vim.bo.filetype

  print("\n--- Available Snippets for Current Filetype (" .. current_filetype .. ") ---")
  local ft_snippets = luasnip.available()[current_filetype]
  if ft_snippets then
    for i, snip in ipairs(ft_snippets) do
      print("  Trigger: " .. snip.trigger .. (snip.name and " (Name: " .. snip.name .. ")" or ""))
    end
  else
    print("  No snippets found for filetype: " .. current_filetype)
  end

  print("\n--- Globally Available Snippets ('all') ---")
  local all_snippets = luasnip.available()["all"]
  if all_snippets then
    for i, snip in ipairs(all_snippets) do
      print("  Trigger: " .. snip.trigger .. (snip.name and " (Name: " .. snip.name .. ")" or ""))
    end
  else
    print("  No global snippets found.")
  end
  print("---------------------------------------------------\n")
end

-- You can then call this function, e.g., by adding a command:
vim.api.nvim_create_user_command("ListActiveSnippets", M.list_snippets_debug, {})

-- require("luasnip.loaders.from_vscode").load { exclude = { "typescript" } }
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
return M
