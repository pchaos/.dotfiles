-- last Modified: 2025-05-01 12:33:54
local M = {}
-- 检测 Telescope 是否可用
local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  vim.notify("Telescope 未安装，跳过配置", vim.log.levels.WARN)
  return
end

-- 加载依赖
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local wk = require("which-key")

-- 加载扩展（如 fzf）
pcall(telescope.load_extension, "fzf")

function M.setup()
  -- 配置 Telescope 核心参数
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<ESC>"] = actions.close, -- 在插入模式按 ESC 关闭窗口
          ["<C-j>"] = actions.move_selection_next, -- 向下选择
          ["<C-k>"] = actions.move_selection_previous, -- 向上选择
        },
      },
      extensions = {
        fzf = { -- 集成 fzf（需提前安装 fzf 命令行工具）
          fuzzy = true,
        },
      },
    },
  })

  -- 绑定快捷键（仅在 Telescope 可用时生效）
  wk.register({
    t = { -- 新增顶层按键 "t"
      name = "Telescope",
      f = { -- 文件搜索子层
        name = "文件搜索",
        f = { builtin.find_files, "搜索文件" },
        g = { builtin.live_grep, "全文检索" },
        b = { builtin.buffers, "缓冲区列表" },
      },
      s = { -- 符号搜索子层
        name = "符号/代码",
        s = { builtin.lsp_document_symbols, "当前文件符号" },
        w = { builtin.lsp_workspace_symbols, "项目符号" },
      },
      g = { -- Git 子层
        name = "Git 工具",
        c = { builtin.git_commits, "提交记录" },
        s = { builtin.git_status, "未提交变更" },
      },
    },
  }, { prefix = "<Leader>" })
end

return M
