-- Modified: 2025-10-31 23:06:33
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

  --------------------------------------------------
  -- 1. 真正干活的函数（已加调试，避开 E16）
  --------------------------------------------------
  local function make_md_link()
    local save_v_reg = vim.fn.getreg('v')
    local save_v_type = vim.fn.getregtype('v')

    vim.cmd([[normal! "vy]])
    local raw = vim.fn.getreg('v')
    local has_eol = raw:sub(-1) == '\n'
    local text = has_eol and raw:sub(1, -2) or raw
    local url = vim.fn.getreg('+') or ''
    local md = '[' .. text .. '](' .. url .. ')' .. (has_eol and '\n' or '')

    vim.schedule(function()
      vim.cmd([[normal! gv]])
      vim.fn.setreg('v', md, 'v')
      vim.cmd([[normal! "vp]])
      vim.fn.setreg('v', save_v_reg, save_v_type)
    end)
  end

  local new_v_mappings = {
    -- 在visual模式下，将选中的文本和系统剪贴板中的URL生成Markdown链接
    l = { make_md_link, 'Wrap selection with Markdown link' },
  }

  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    print("which-key not found")
    return
  end

  -- 注册新的映射
  which_key.register(new_b_mappings, { mode = "n", prefix = "<leader>b", silent = true })
  which_key.register(new_v_mappings, { mode = "v", prefix = "<leader>b", silent = true })
end

return M
