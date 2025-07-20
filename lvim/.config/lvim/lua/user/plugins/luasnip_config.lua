-- Modified: 2025-07-20 21:49:18
local M = {}
local luasnip = require('luasnip')
-- local vscode_loader = require('luasnip.loaders.from_vscode')

function M.setup()
  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
      local status, vscode_loader = pcall(require, 'luasnip.loaders.from_vscode')

      if status then
        local home_dir = vim.fn.stdpath("config")

        -- local custom_snippets_path = home_dir .. "/snippets/all.json"
        local custom_snippets_path = home_dir .. "/"
        print("DEBUG: Expected custom snippets path: " .. custom_snippets_path)

        local success, err = pcall(function()
          vscode_loader.load({ paths = custom_snippets_path })
        end)
        -- luasnip.snippets = luasnip.loaders.from_vscode().load({ paths= custom_snippets_path })
        if success then
          print("Snippets loaded successfully.")
        else
          -- 如果加载失败，输出错误信息 
          print("Error loading snippets: " .. err)
        end
      else
        -- 调试信息：插件模块加载失败
        debug_print("init.lua: Failed to load plugin module 'user.plugins.auto-update-timestamp': " .. autotimestamp,
                    vim.log.levels.ERROR)
      end
    end,
    once = true, -- 确保这个自动命令只执行一次
  })
end

return M
