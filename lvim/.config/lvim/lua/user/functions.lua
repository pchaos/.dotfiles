-- Last Modif:ied: 2024-02-21 12:22:59
local M = {}
function M.findCommandPath(command)
  --[[ 调用函数来查找 shell(python,doq) 命令的路径
local doq_path = findCommandPath("doq")

if doq_path ~= "" then
  print("Found doq path: " .. doq_path)
end
  -- ]]
  local handle = io.popen("which " .. command)
  local commandPath = handle:read("*a")
  handle:close()
  commandPath = string.gsub(commandPath, "\n", "")

  if commandPath == "" then
    print("未找到 " .. command .. " 命令，请确保已安装该工具")
  end

  return commandPath
end

function M.isempty(s)
  return s == nil or s == ""
end

function M.printing(toprint)
  vim.api.nvim_echo({ { toprint } }, true, {})
end

-- 设置全局变量的路径
function M.setGlobalVarPath(shellCommand, varName, commandFunc)
  -- 默认使用 m.findCommandPath 函数查找命令路径
  commandFunc = commandFunc or M.findCommandPath
  if M.isempty(varName) then
    print(shellCommand .. "can't set to nil")
  end
  -- pathPrefix = pathPrefix or ""
  -- pathSuffix = pathSuffix or "_path"
  local commandPath = commandFunc(shellCommand)

  -- 如果找到命令路径，则将其设置到全局变量中
  if commandPath ~= "" then
    -- print("Found " .. doqCommand .. " path: " .. doqPath)
    -- local varName = pathPrefix .. shellCommand .. pathSuffix
    -- print(varName)
    vim.g[varName] = commandPath
  end
end

function M.showAutoDismissMessage(message, timeout)
  -- 调用函数显示消息（使用默认的五秒超时时间）
  -- showAutoDismissMessage("这是一条自动消失的消息")
  timeout = timeout or 5000 -- 如果没有提供超时时间参数，则使用默认值（单位为毫秒）

  vim.notify(message, vim.log.levels.INFO, { timeout = timeout })
end

-- 定义合并选中区域内空行的函数
function M.merge_empty_lines()
  local selected = vim.fn.visualmode() == "V" or vim.fn.visualmode() == "v"
  if selected then
    -- 获取选中区域的起始行和结束行
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    -- 遍历选中区域内的每一行
    local merged_empty_line = false
    for line = start_line, end_line do
      -- 获取当前行的内容
      local current_line = vim.fn.getline(line)

      -- 如果当前行是空行或者仅包含空格或tab字符，则与下一行合并
      -- if current_line:match("^[ \t]*\n*$") and line < end_line then
      if current_line:match("^%s*$") and line < end_line then
        if not merged_empty_line then
          merged_empty_line = true
          vim.api.nvim_command(tostring(line) .. "j") -- 将光标移动到下一行
          vim.api.nvim_command("d") -- 删除当前行
        else
          vim.api.nvim_command("d") -- 删除当前行 ???
        end
      else
        merged_empty_line = false
      end
    end
  end
end

function M.delete_empty_lines()
  --[[删除包含tab键和空格的多个空行为一个空行
  首先检查是否有文本被选择。如果有文本被选择，则使用 '<,'> 来表示当前选择的范围，然后执行删除空行的操作；否则，作用于整个 buffer 的所有内容。
  --]]
  local selected = vim.fn.visualmode() == "V" or vim.fn.visualmode() == "v"
  if selected then
    -- M.merge_empty_lines()
    vim.api.nvim_command("\'<,\'>g/^\\s*$\\n\\s*$/d")
  else
    vim.api.nvim_command("g/^\\s*$\\n\\s*$/d")
    vim.api.nvim_command("nohlsearch")
  end
end

return M
