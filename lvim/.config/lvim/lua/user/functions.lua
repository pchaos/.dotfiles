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

return M
