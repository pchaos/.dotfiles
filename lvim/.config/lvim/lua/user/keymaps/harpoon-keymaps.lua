-- Modified: 2025-07-25 15:17:11
--[[ Harpoon 快捷键：
<leader>a：将当前文件添加到 Harpoon 列表中。
<leader>m：打开 Harpoon 的书签组菜单，包含以下子命令：
<leader>ma：将当前文件添加到 Harpoon 列表中（快捷方式）。
<leader>me：切换 Harpoon 的快速菜单（展示所有已标记文件）。
<leader>m0：通过 Telescope 搜索 Harpoon 标记的文件。
<leader>m1 至 <leader>m5：选择 Harpoon 列表中的第 1 至 5 个文件进行快速跳转。
<leader>,：跳转到上一个标记文件。
<leader>.：跳转到下一个标记文件 
--]] --
local M = {}
local harpoon = require("harpoon")
harpoon.setup({ global_settings = { save_on_toggle = true, save_on_exit = true, max_size = 15 } })

vim.api.nvim_set_var("harpoon_save_path", "~/.config/lvim/harpoon")

local function add_harpoon_prefix(descriptor)
  if type(descriptor) == "string" then
    -- 检测是否已包含前缀（避免重复添加）
    if not descriptor:find("[hH]arpoon") then
      return "Harpoon " .. descriptor
    end
  end
  return descriptor
end

-- 定义 which-key 注册函数
local setup_whichkey = function()
  local wk = require("which-key")

  wk.register({
    ["<leader>"] = {
      a = {
        function()
          harpoon:list():add()
        end,
        "添加文件到 Harpoon",
      },
      m = {
        name = "+Bookmarks", -- 分组名称
        a = {
          function()
            harpoon:list():add()
          end,
          add_harpoon_prefix("添加当前文件"),
        },
        e = {
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          add_harpoon_prefix("切换快速菜单"),
        },
        ["0"] = { "<cmd>Telescope harpoon marks<cr>", add_harpoon_prefix("Search Files") },
        ["1"] = {
          function()
            harpoon:list():select(1)
          end,
          add_harpoon_prefix("选择文件1"),
        },
        ["2"] = {
          function()
            harpoon:list():select(2)
          end,
          add_harpoon_prefix("选择文件2"),
        },
        ["3"] = {
          function()
            harpoon:list():select(3)
          end,
          add_harpoon_prefix("选择文件3"),
        },
        ["4"] = {
          function()
            harpoon:list():select(4)
          end,
          add_harpoon_prefix("选择文件4"),
        },
        ["5"] = {
          function()
            harpoon:list():select(5)
          end,
          add_harpoon_prefix("选择文件5"),
        },
        [","] = {
          function()
            harpoon:list():prev()
          end,
          add_harpoon_prefix("上一个文件"),
        },
        ["."] = {
          function()
            harpoon:list():next()
          end,
          add_harpoon_prefix("下一个文件"),
        },

      },
    },
    ["<C-e>"] = {
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      "切换Harpoon菜单",
    },
  }, { mode = "n" }) -- 仅普通模式
end

function M.config()
  -- 初始化 which-key
  setup_whichkey()
end
return M
