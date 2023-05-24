-- Last Modified: 2023-05-19 23:36:26

local dap = require('dap')
local python_install_path = vim.fn.exepath('python')

--[[
当然还有其他更多选项可以用啦，看标题就知道这只是简单配置一下，我的目前时间也不多就暂时能用就行，
主要还是向能脱离IDE
]]
dap.adapters.python = {
  type = "executable",
  -- command = '/usr/bin/python',
  command = python_install_path,
  args = { '-m', 'debugpy.adapter' },
}

local get_args = function()
  -- 获取输入命令行参数
  local cmd_args = vim.fn.input('CommandLine Args:')
  local params = {}
  -- 定义分隔符(%s在lua内表示任何空白符号)
  local sep = "%s"
  for param in string.gmatch(cmd_args, "[^%s]+") do
    table.insert(params, param)
  end
  return params
end;


dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'launch file',
    -- 此处指向当前文件
    program = '${file}',
    args = get_args,
    pythonpath = function()
      -- return '/usr/bin/python'
      return python_install_path
    end,
  },
}
