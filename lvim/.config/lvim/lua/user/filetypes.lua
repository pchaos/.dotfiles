-- Last modified:   2025-04-29 15:14:29
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md\\c", -- \c 使匹配忽略大小写
  command = "set filetype=markdown",
})

