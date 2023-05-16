--  Modified: 2023-05-17 01:13:06

-- codelldb debug 配置
-- cpp, c debug配置
require('user.dap-configs.dap-codelldb')
--
-- go debug 配置
require('user.dap-configs.dap-go')

-- rust debug 配置
-- 也可以使用rust-tools下RustDebugee命令触发
require('user.dap-configs.dap-rust')

-- python debug配置
require('user.dap-configs.dap-python')
