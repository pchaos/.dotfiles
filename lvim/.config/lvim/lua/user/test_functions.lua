-- 测试 m.findCommandPath 函数
-- Last Modified: 2024-02-22 11:21:27
local m = require("user.functions")

-- 测试 "doq" 命令
local doqPath = m.findCommandPath("doq")
if doqPath == "" then
  error("未找到 doq 命令")
end
print(doqPath)

-- 测试 "vim" 命令
local vimPath = m.findCommandPath("vim")
if vimPath == "" then
  error("未找到 vim 命令")
end

-- 测试不存在的命令
local nonExistentCommandPath = m.findCommandPath("non_existent_command")
if nonExistentCommandPath ~= "" then
  error("找到了不存在的命令")
end

-- m.setGlobalVarPath("doq", "pydocstring")
-- print(vim.g.pydocstring_doq_path)
print("所有测试通过")
