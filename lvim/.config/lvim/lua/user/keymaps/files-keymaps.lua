-- Modified: 2025-07-29 18:08:58
---- Description: This module sets up key mappings for copying file paths and names
-- using the <leader>b prefix in normal mode. It integrates with
local M = {}

function M.setup()
  -- 动态添加新的映射，避免与其他 <leader>p 冲突
  local new_b_mappings = {
    -- 使用 <leader>ba 来复制当前文件路径
    a = { "<cmd>let @+ = expand('%:p')<cr>", "Copy full File Path" },
    -- 快捷键复制当前文件的路径（不包含文件名）
    p = { "<cmd>let @+ = expand('%:p:h')<cr>", "Copy File Path (Without File Name)" },
    y = { "<cmd>let @+ = expand('%:t')<cr>", "Copy File Name" },
  }

  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    print("which-key not found")
    return
  end
  -- 注册新的映射
  which_key.register(new_b_mappings, { mode = "n", prefix = "<leader>b", silent = true })
end

return M
