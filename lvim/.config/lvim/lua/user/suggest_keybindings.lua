--[[
Last Modified: 2023-07-02 23:54:02
---- 调用函数来检查并提供快捷键建议
local key = "<leader>f" -- 替换为你要检查的快捷键
suggestKeyBindings(key)
--]] --
local fn = vim.fn

if not SUGGEST_KEYBINDINGS_LOADED then
  SUGGEST_KEYBINDINGS_LOADED = true
else
  return
end

-- 定义函数来检查快捷键是否被占用，并返回完整的占用信息
local function checkKeyBindingExists(key)
  local cmd = string.format("verbose map '%s'", key)
  local output = fn.execute(cmd)

  -- 如果输出不为空，表示快捷键被占用
  if output and #output > 0 then
    return table.concat(output, '\n')
  else
    return nil
  end
end

-- 定义函数来生成类似且未被占用的快捷键
local function generateAvailableKeyBindings(key)
  local availableKeys = {}

  for i = 1, 9 do
    local newKey = string.gsub(key, "%d", tostring(i))
    if not checkKeyBindingExists(newKey) then table.insert(availableKeys, newKey) end
  end

  return availableKeys
end

-- 定义函数来检查某个快捷键是否被占用，并提供类似但尚未被占用的快捷键建议
function suggestKeyBindings(key)
  local info = checkKeyBindingExists(key)

  if info then
    print(string.format("快捷键 %s 被占用的详细信息:\n%s", key, info))

    local similarKeys = generateAvailableKeyBindings(key)
    if #similarKeys > 0 then
      print("以下类似但尚未被占用的快捷键可供考虑:")
      for _, similarKey in ipairs(similarKeys) do print(similarKey) end
    else
      print("没有找到类似且尚未被占用的快捷键")
    end
  else
    print("快捷键", key, "未被占用")
  end
end
