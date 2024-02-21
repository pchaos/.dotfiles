-- Last Modif:ied: 2024-02-21 12:22:59
local m = {}
function m.findCommandPath(command)
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

-- 设置全局变量的路径
function m.setGlobalVarPath(shellCommand, pathPrefix, pathSuffix, findCommandPathFunc)
  -- 默认使用 m.findCommandPath 函数查找命令路径
  findCommandPathFunc = findCommandPathFunc or m.findCommandPath
  pathPrefix = pathPrefix or ""
  pathSuffix = pathSuffix or "_path"
  local commandPath = findCommandPathFunc(shellCommand)

  -- 如果找到命令路径，则将其设置到全局变量中
  if commandPath ~= "" then
    -- print("Found " .. doqCommand .. " path: " .. doqPath)
    local varName = pathPrefix .. shellCommand .. pathSuffix
    -- print(varName)
    vim.g[varName] = commandPath
  end
end

return m
