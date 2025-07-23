-- encoding=utf-8
-- ~/.config/nvim/lua/auto-update-timestamp.lua
-- Modified: 2025-07-23 19:17:51
--[[ 这个 Lua 插件（auto-update-timestamp.lua）的主要作用是为 Neovim 提供一个自动更新文件时间戳的功能。

具体来说，它的核心功能是在您保存文件之前（通过 BufWritePre 自动命令），自动查找文件中的特定时间戳字符串（如 "Modified: YYYY-MM-DD HH:MM:SS" 或 "Last Modified: YYYY-MM-DD HH:MM:SS"），并将其更新为当前的日期和时间。

总结来说，这个插件的作用是：

自动化时间戳更新：在文件保存时自动更新文件中的“修改时间”标记。

可配置的搜索范围：只在文件的前 N 行和后 N 行中查找时间戳，提高效率。

文件类型/名称忽略：允许用户配置哪些文件类型或特定文件不进行时间戳更新。

可控的调试输出：提供一个 debug_mode 开关，方便用户在需要时打开详细的调试信息，在日常使用时保持简洁。

它旨在帮助用户管理文档或代码文件中的修改日期信息，确保这些信息始终是最新的，而无需手动更改。
注意:
对于特别大的文件，这种方式确实会暂时性地增加内存占用，但在大多数情况下是值得的。
对于绝大多数日常编辑的文件，当前的实现是高效且可靠的。如果您确实需要处理极其庞大的文件（例如，作为日志处理工具），并且内存成为瓶颈，那么可能需要考虑更复杂的策略，例如：

只读取和处理文件的一小部分（例如，只读取和写入前 N 行，而不是整个文件）。

使用 Neovim API 中更底层的缓冲区操作，直接修改特定行的内容，而不是操作整个行列表。

但这些替代方案会大大增加插件的复杂性。对于当前插件的“在文件头尾查找并更新时间戳”的场景，目前的实现是合理的折衷。
 ]] local M = {}

-- 默认配置
local config = {
  search_lines = 10, -- 默认搜索文件的前10行和后10行
  ignore_file_types = {}, -- 需要忽略的文件类型列表（可以根据需要填写）
  ignore_file_names = {}, -- 需要忽略的文件名列表（可以根据需要填写）
  debug_mode = false, -- 调试模式开关，控制是否输出调试信息
  log_notify = false, -- 是否通过vim.notify输出日志
  message_prefix = "Auto-Update-Timestamp: ", -- 调试信息的前缀
}

-- 只有当 config.debug_mode 为 true 时才输出调试信息
-- msg: 要输出的消息
-- debug_level: 输出的日志级别（默认为INFO级别）
-- force_print: 是否强制输出，即使debug_mode为false时也会输出
local function debug_print(msg, debug_level, force_print)
  debug_level = debug_level or vim.log.levels.INFO -- 默认日志级别为INFO
  force_print = force_print or false -- 默认为false，不强制输出
  if config.debug_mode or force_print or debug_level >= vim.log.levels.WARN then -- 仅在debug_mode为true或must_print为true时输出
    if config.log_notify or debug_level >= vim.log.levels.WARN then -- 如果启用vim.notify，使用notify输出
      vim.notify(config.message_prefix .. msg, debug_level) -- 使用vim.notify显示消息
    else -- 否则使用print输出
      print(config.message_prefix .. msg) -- 直接在终端打印消息
    end
  end
end

---更新配置
---@param new_config table
function M.setup(new_config)
  config = vim.tbl_deep_extend("force", config, new_config or {})
end

---设置要忽略的文件类型
---@param filetype string|string[] 单个文件类型或文件类型列表
function M.set_ignore_file_type(filetype)
  if type(filetype) == "string" then
    config.ignore_file_types[filetype] = true
  elseif type(filetype) == "table" then
    for _, ft in ipairs(filetype) do
      config.ignore_file_types[ft] = true
    end
  end
end

---清空所有忽略的文件类型
function M.clear_ignore_file_type()
  config.ignore_file_types = {}
end

function M.set_debug_mode(new_mode)
  new_mode = new_mode or false
  config.debug_mode = new_mode
end
---设置要忽略的文件名 (完整文件名，例如 "README.md")
---@param filename string|string[] 单个文件名或文件名列表
function M.set_ignore_file_name(filename)
  if type(filename) == "string" then
    config.ignore_file_names[filename] = true
  elseif type(filename) == "table" then
    for _, fn in ipairs(filename) do
      config.ignore_file_names[fn] = true
    end
  end
end

---清空所有忽略的文件名
function M.clear_ignore_file_name()
  config.ignore_file_names = {}
end

local function process_line(line, i, pattern, prefix_pattern, current_time, updated_lines, timestamp_found)
  -- 使用 string.format("%q", line) 打印行的精确内容，包括不可见字符
  -- debug_print("Attempting match on line " .. i .. " (raw): " .. string.format("%q", line), vim.log.levels.DEBUG)
  debug_print("Attempting match on line " .. i .. " (raw): " .. string.format("%q", line) .. pattern,
              vim.log.levels.DEBUG)
  if line:match(pattern) then
    debug_print("Found match in line " .. i .. ": '" .. line .. "'", vim.log.levels.INFO)
    -- 替换匹配到的时间戳
    -- function(match) 用于在替换时保留 "Modified: " 或 "Last Modified: " 前缀
    line = line:gsub(pattern, function(match)
      -- 提取前缀部分 (例如 "Modified: " 或 "Last Modified : ")
      local actual_prefix = match:match(prefix_pattern)
      return actual_prefix .. current_time -- 将前缀与新时间戳拼接
    end)
    timestamp_found = true -- 标记已找到并更新
    updated_lines[i] = line
    debug_print("updated line " .. i .. ": '" .. line .. "'", vim.log.levels.INFO, true)
  else
    -- 即使没有匹配，也显示该行的精确内容
    debug_print("No pattern match in line " .. i .. " (raw): " .. string.format("%q", line), vim.log.levels.INFO)
  end
  return line, timestamp_found, updated_lines
end

---核心功能：更新文件中的时间戳
local function update_timestamp()
  local current_buf = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[current_buf].filetype
  -- 获取当前缓冲区的完整文件名，然后只取文件名部分 (例如 "README.md")
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(current_buf), ":t")

  debug_print("update_timestamp called for file: " .. filename, vim.log.levels.INFO)

  -- 检查当前文件类型或文件名是否在忽略列表中
  if config.ignore_file_types[filetype] or config.ignore_file_names[filename] then
    debug_print("Ignoring file '" .. filename .. "' (filetype: " .. filetype .. ")")
    return -- 如果需要忽略，则直接返回，不执行更新
  end

  -- 获取当前缓冲区的所有行
  local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
  local num_lines = #lines -- 获取总行数
  local updated_lines = {}
  for k = 1, num_lines do
    updated_lines[k] = lines[k]
  end
  local timestamp_found = false -- 标记是否找到了时间戳并进行了更新

  -- 获取当前日期时间，格式为 YYYY-MM-DD HH:MM:SS
  local current_time = os.date("%Y-%m-%d %H:%M:%S")
  -- debug_print("Current time: " .. current_time, vim.log.levels.INFO)

  local pattern = [[[mM]odified%s*[:]+%s*%d%d%d%d%-%d%d%-%d%d%s*%d%d:%d%d:%d%d]]
  debug_print("Regex pattern: " .. pattern, vim.log.levels.DEBUG)
  local pattern_timestamp = "[mM]odified%s*[:]+%s*TIMESTAMP"
  local prefix_pattern = [[[mM]odified%s*[:]+%s*]]
  local pattern_create_timestamp = "[cC]reated%s*[:]+%s*TIMESTAMP"
  local prefix_create_pattern = [[[cC]reated%s*[:]+%s*]]
  local datetime_only_pattern = [[%d%d%d%d%-%d%d%-%d%d%s+%d%d%:%d%d%:%d%d]]
  debug_print("Datetime only pattern: " .. datetime_only_pattern, vim.log.levels.DEBUG)
  -- local prefix_pattern = [[[mM]odified%s*[:%s]*]]

  -- 遍历所有行，并只在指定范围内进行查找和替换
  debug_print(
    "Auto-Update Timestamp: Checking lines within search range (top " .. config.search_lines .. " and bottom " ..
      config.search_lines .. " lines).", vim.log.levels.INFO)
  for i = 1, num_lines do
    -- 判断当前行是否在前 N 行或后 N 行的范围内
    -- local is_in_search_range = (i <= config.search_lines) or (i > num_lines - config.search_lines)

    local is_in_search_range = (i <= config.search_lines) or (i > num_lines - math.min(config.search_lines, num_lines))
    if is_in_search_range then
      local line = lines[i]
      local line_original = line

      line, timestamp_found, updated_lines = process_line(line, i, pattern, prefix_pattern, current_time, updated_lines,
                                                          timestamp_found)
      if line_original == line then
        line, timestamp_found, updated_lines = process_line(line, i, pattern_timestamp, prefix_pattern, current_time,
                                                            updated_lines, timestamp_found)
        line, timestamp_found, updated_lines = process_line(line, i, pattern_create_timestamp, prefix_create_pattern,
                                                            current_time, updated_lines, timestamp_found)
      else
        debug_print(line_original .. " -> " .. line, vim.log.levels.DEBUG)
      end
    else
      -- 如果不在搜索范围内，可以跳过或进行其他处理
      -- debug_print("Skipping line " .. i .. " (outside search range).", vim.log.levels.INFO)
    end
  end

  -- 如果在文件前 N 行或后 N 行找到了时间戳并进行了更新
  if timestamp_found then
    -- 使用 nvim_buf_set_lines 更新整个缓冲区的内容
    vim.api.nvim_buf_set_lines(current_buf, 0, num_lines, false, updated_lines)
    debug_print("Successfully updated timestamp for file: " .. filename, vim.log.levels.INFO)
  else
    debug_print("No timestamp pattern found in file: " .. filename, vim.log.levels.INFO)
  end
end

---提供帮助信息
function M.help()
  print([[
# Auto-Update Timestamp Plugin Help

This plugin automatically updates a "Modified" or "Last Modified" timestamp in your files upon saving.

## Configuration:
You can configure the plugin in your `init.lua` (or `init.vim` for VimL).

### Setting Search Lines:
Set the number of lines to search at the beginning and end of the file.
Example:
```lua
require('user.plugins.auto-update-timestamp').setup({
    search_lines = 15 -- Search the first and last 15 lines
})
```

### Ignoring File Types:
Prevent timestamp updates for specific file types.
Example:
```lua
require('user.plugins.auto-update-timestamp').set_ignore_file_type("markdown")
require('user.plugins.auto-update-timestamp').set_ignore_file_type({"json", "yaml"}) -- Multiple file types
```

### Clearing Ignored File Types:
Remove all file types from the ignore list.
Example:
```lua
require('user.plugins.auto-update-timestamp').clear_ignore_file_type()
```

### Ignoring File Names:
Prevent timestamp updates for specific file names (e.g., "README.md").
Example:
```lua
require('auto-update-timestamp').set_ignore_file_name("README.md")
require('auto-update-timestamp').set_ignore_file_name({"CHANGELOG.md", "LICENSE"}) -- Multiple file names
```

### Clearing Ignored File Names:
Remove all file names from the ignore list.
Example:
```lua
require('user.plugins.auto-update-timestamp').clear_ignore_file_name()
```

## How it Works:
When you save a file, the plugin will look for lines containing "Modified: YYYY-MM-DD HH:MM:SS" or "Last Modified: YYYY-MM-DD HH:MM:SS" (case-insensitive for "Modified" and "Last", and tolerating various spaces/tabs). If found within the configured search lines, the date and time will be updated to the current timestamp.

## Commands:
- `:lua require('user.plugins.auto-update-timestamp').setup({ search_lines = 20 })` : Configure the search lines.
- `:lua AutoUpdateTimestamp.setup({ search_lines = 20 })` : 使用全局别名配置搜索行。
- `:lua require('user.plugins.auto-update-timestamp').set_ignore_file_type("markdown")` : 忽略 markdown 文件。
- `:lua AutoUpdateTimestamp.set_ignore_file_type("markdown")` : 使用全局别名忽略 markdown 文件。
- `:lua require('user.plugins.auto-update-timestamp').clear_ignore_file_type()` : 清空忽略的文件类型。
- `:lua AutoUpdateTimestamp.…Timestamp.set_ignore_file_name("README.md")` : 使用全局别名忽略 "README.md"。
- `:lua require('user.plugins.auto-update-timestamp').clear_ignore_name()` : 清空忽略的文件名。
- `:lua AutoUpdateTimestamp.clear_ignore_name()` : 使用全局别名清空忽略的文件名。
- `:lua require('user.plugins.auto-update-timestamp').set_debug_mode(true)` : 启用调试模式。
- `:lua AutoUpdateTimestamp.set_debug_mode(true)` : 使用全局别名启用调试模式。
- `:lua require('user.plugins.auto-update-timestamp').help()` : 显示此帮助信息。
- `:lua AutoUpdateTimestamp.help()` : 使用全局别名显示此帮助信息。
]])
end

function M.config()
  -- 确保在 VimEnter 事件后执行插件的设置
  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("AutoUpdateTimestampConfig", { clear = true }),
    callback = function()
      -- 调试信息：确认 VimEnter 自动命令回调已触发
      -- debug_print("init.lua: VimEnter autocmd callback triggered.", vim.log.levels.INFO)

      -- 尝试加载您的插件模块
      local status, autotimestamp = pcall(require, 'user.plugins.auto-update-timestamp')

      if status then
        -- 调试信息：确认插件模块已成功加载
        debug_print("init.lua: Plugin module 'user.plugins.auto-update-timestamp' loaded successfully.",
                    vim.log.levels.INFO)

        -- 调用 setup 函数进行基本配置
        autotimestamp.setup({
          search_lines = 10, -- 您可以根据需要调整此值
          debug_mode = false, -- 设置为 false 禁用调试模式
        })
        debug_print("init.lua: Plugin setup() called.", vim.log.levels.INFO)

        -- 示例：设置要忽略的文件类型 (取消注释以启用)
        -- autotimestamp.set_ignore_file_type({"markdown", "json"})
        -- debug_print("init.lua: Ignored file types set.", vim.log.levels.INFO)

        -- 示例：设置要忽略的文件名 (取消注释以启用)
        -- autotimestamp.set_ignore_file_name("README.md")
        -- debug_print("init.lua: Ignored file names set.", vim.log.levels.INFO)

        debug_print("Plugin configuration applied.", vim.log.levels.INFO)
      else
        -- 调试信息：插件模块加载失败
        debug_print("init.lua: Failed to load plugin module 'user.plugins.auto-update-timestamp': " .. autotimestamp,
                    vim.log.levels.ERROR)
      end
    end,
    once = true, -- 确保这个自动命令只执行一次
  })
end

-- 注册 BufWritePre 自动命令
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("AutoUpdateTimestamp", { clear = true }),
  callback = update_timestamp, -- 调用核心更新函数
  pattern = "*", -- 针对所有文件
  debug_print("Plugin loaded", vim.log.levels.INFO),
})

-- 将模块暴露为全局变量，方便在命令行直接调用
_G.AutoUpdateTimestamp = M

return M
