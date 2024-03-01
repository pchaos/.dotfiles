--
-- Last Modified: 2024-02-23 00:19:35
-- 定义全局变量
-- require("os")
local last_relative_dir = ""

-- function map(mode, shortcut, command)
--   vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
-- end

-- function nmap(shortcut, command)
--   map('n', shortcut, command)
-- end

-- function imap(shortcut, command)
--   map('i', shortcut, command)
-- end

-- 定义映射
nmap("\\1", '<ESC>:call RelatedFile("models.py")<cr>')
nmap("\\2", 'function() RelatedFile("views.py") end')

-- lvim.keys.normal_mode["<A-h>"] = ":bprev<cr>" --
-- nmap("\\2", '<ESC>:call RelatedFile("views.py")<cr>')
nmap("\\3", '<ESC>:call RelatedFile("urls.py")<cr>')
nmap("\\4", '<ESC>:call RelatedFile("admin.py")<cr>')
nmap("\\5", '<ESC>:call RelatedFile("tests.py")<cr>')
nmap("\\6", '<ESC>:call RelatedFile("templates/")<cr>')
nmap("\\7", '<ESC>:call RelatedFile("templatetags/")<cr>')
nmap("\\8", '<ESC>:call RelatedFile("management/")<cr>')
nmap("\\9", '<ESC>:call RelatedFile("settings.py")<cr>')

local printbb = require("user.functions").printing

-- 定义一个函数，用于递归查找指定目录中的特定文件或目录，最多向上递归查找到三级目录
local function find_django_dir(dir, target_name, upperDepth)
  upperDepth = upperDepth or 3

  if upperDepth <= 0 then
    return ""
  end
  printbb("dir:" .. dir)

  if target_name == nil or target_name == "" then
    target_name = "manage.py"
  end

  local file_type = vim.fn.getftype(dir)

  if file_type == 'directory' then
    -- 使用 vim.fn.readdir() 函数列出目标目录下的所有文件和目录
    local entries = vim.fn.readdir(target_directory)
    printbb("entries:" .. entries)
    for _, entry in ipairs(entries) do
      printbb("entry:" .. entry)
      local full_path = dir .. '/' .. entry
      local entry_type = vim.fn.getftype(full_path)

      if entry_type == 'directory' and entry ~= '.' and entry ~= '..' then
        if entry == target_name then
          printbb('找到目标目录：' .. full_path)
          return entry
        else
          local result = find_django_dir(full_path, target_name, upperDepth - 1)
          if result ~= "" then
            return result
          end
        end
      elseif entry_type == 'file' and entry == target_name then
        printbb('找到目标文件：' .. full_path)
        return entry
      end
    end
  else
    -- 如果当前目录不存在，则向上查找一级目录
    local parent_directory = vim.fn.fnamemodify(dir, ':h')
    return find_django_dir(parent_directory, target_name, upperDepth - 1)
  end

  return ""
end

-- print(_VERSION)
-- local cache = {}
-- local django_dir = ""
-- local function find_django_dir1(dir, target_file, level)
--   --[[
--    该代码用于在指定目录及其子目录中递归查找特定文件，通常用于定位 Django 项目目录。
--   我来解释这段代码的作用：
--   功能： 该代码用于在指定目录及其子目录中递归查找特定文件，通常用于定位 Django 项目目录。

--   参数：

--   dir: 起始查找目录。
--   target_file: 要查找的文件名，默认为 "manage.py"（Django 项目的标志性文件）。
--   level: 允许递归查找的最大层数，默认为 3 层。

-- local target_file = "manage.py"
-- local level = 3
-- local django_dir = find_django_dir(os.getcwd(), target_file, level)

-- if django_dir then
--   print("找到 Django 目录:", django_dir)
-- else
--   print("未找到 Django 目录")
-- end

--   --]]
--   -- 检查缓存
--   local cached_result = cache[dir]
--   if cached_result then
--     return cached_result
--   end

--   if target_file == nil or target_file == "" then
--     target_file = "manage.py"
--   end
--   level = level or 3

--   if level <= 0 then
--     return ""
--   end

--   for _, subdir in ipairs(os.listdir(dir)) do
--     if string.match(subdir, target_file) then
--       cache[dir] = subdir
--       return subdir
--     end
--   end

--   for _, subdir in ipairs(os.listdir(dir)) do
--     if os.isdir(subdir) then
--       local found = find_django_dir(subdir, target_file, level - 1)
--       if found then
--         cache[dir] = found
--         return found
--       end
--     end
--   end

--   cache[dir] = nil
--   return ""
-- end

-- 定义 RelatedFile 函数
function RelatedFile(file)
  if not file or type(file) ~= "string" then
    vim.api.nvim_echo({ { "参数错误：file 必须是字符串类型", "ErrorMsg" } }, true, {})
    return
  end
  -- 检查目录是否符合 Django 项目结构
  local current_dir = vim.fn.expand("%:h")

  -- vim.api.nvim_echo("current_dir: " .. current_dir, true, {})
  -- printbb("current_dir: " .. current_dir)
  django_dir = find_django_dir(current_dir, "", 3)

  if django_dir ~= nil and django_dir ~= "" then
    last_relative_dir = django_dir .. "/"
    printbb("找到 Django 目录:" .. django_dir)
  else
    printbb("未找到 Django 目录")
  end

  last_relative_dir = find_django_dir(last_relative_dir, file, 1)
  -- 如果最近的相对目录非空，则尝试在其中打开文件
  if last_relative_dir ~= "" then
    vim.cmd("edit " .. last_relative_dir .. file)
    return
  end
  -- 显示错误信息
  vim.api.nvim_echo({ { "无法确定相对文件的位置：", "ErrorMsg" } }, true, {})
end

-- 定义 SetAppDir 函数
function SetAppDir()
  local current_dir = vim.fn.expand("%:h")
  printbb("current directory:" .. current_dir)
  -- 检查当前目录是否符合 Django 项目结构
  django_dir = find_django_dir(current_dir, "", 4)

  if django_dir ~= nil and django_dir ~= "" then
    last_relative_dir = django_dir .. "/"
    printbb("找到 Django 目录:" .. django_dir)
  else
    printbb("未找到 Django 目录")
  end
end

-- 定义自动命令
vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = "*.py", callback = SetAppDir })
