-- Modified: 2025-11-01 00:11:02
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
  -- 将选中文本和剪贴板URL生成Markdown链接
  --------------------------------------------------
  local function make_md_link()
    -- 保存当前 'v' (visual) 寄存器和 '+' (系统剪贴板) 寄存器的内容及类型
    -- 这是为了在函数执行完毕后恢复这些寄存器的原始状态，避免副作用。
    local save_v_reg = vim.fn.getreg('v')
    local save_v_type = vim.fn.getregtype('v')
    local save_plus_reg = vim.fn.getreg('+')
    local save_plus_type = vim.fn.getregtype('+')

    -- 执行 normal 模式命令 "vy，将当前视觉选择区域的内容复制到 'v' 寄存器
    vim.cmd([[normal! "vy]])
    local raw = vim.fn.getreg('v') -- 获取 'v' 寄存器中的原始文本

    -- 检查原始文本是否以换行符结尾。如果以换行符结尾，则在处理时去除它，并在生成Markdown链接时再添加回来。
    local has_eol = raw:sub(-1) == '\n'
    local text = has_eol and raw:sub(1, -2) or raw -- 链接的文本部分

    -- 获取系统剪贴板 ('+' 寄存器) 中的内容作为 URL。如果剪贴板为空，则默认为空字符串。
    local url = vim.fn.getreg('+') or '' -- 链接的 URL 部分

    -- 构造 Markdown 格式的链接：[text](url)，并根据原始文本是否包含换行符来决定是否添加换行符。
    local md = '[' .. text .. '](' .. url .. ')' .. (has_eol and '\n' or '')

    -- 使用 vim.schedule 异步执行后续操作，确保在 Neovim 事件循环中正确处理。
    vim.schedule(function()
      vim.cmd([[normal! gv]]) -- 重新选择之前视觉模式选中的区域

      vim.fn.setreg('v', md, 'v') -- 将构造好的 Markdown 链接设置到 'v' 寄存器
      vim.cmd([[normal! "vp]]) -- 从 'v' 寄存器粘贴内容，替换掉之前选中的文本

      -- 恢复 'v' 和 '+' 寄存器的原始内容和类型
      vim.fn.setreg('v', save_v_reg, save_v_type)
      vim.fn.setreg('+', save_plus_reg, save_plus_type)
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
