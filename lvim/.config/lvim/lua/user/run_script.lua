-- lunarvim中，通过判断文件后缀，设置快捷键运行程序
-- Last Modified: 2023-06-13 14:43:42

function get_run_command()
  local filetype = vim.bo.filetype

  if filetype == "python" then
    return "python " .. vim.fn.expand('%')
  elseif filetype == "c" or filetype == "cpp" then
    return "gcc -Wall -Wextra -Werror -O2 % -lm -o %:p:r"
  elseif filetype == "rust" then
    return "rustc % -o %:p:r"
  elseif filetype == "xmake" then
    return "xmake run " .. vim.fn.expand('%:p')
  elseif filetype == "lua" then
    return "lua " .. vim.fn.expand('%')
  elseif filetype == "sh" then
    return "bash " .. vim.fn.expand('%')
  else
    return nil
  end
end

-- Set keybindings to run command for current filetype
lvim.keys.normal_mode["<leader>r"] = {
  name = "+Run",
  r = { "<cmd> lua require('user.utils').run_command(get_run_command())<cr>", "Run" },
}
