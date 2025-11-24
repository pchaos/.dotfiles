-- Last modified:   2025-11-12 18:36:44
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md\\c", -- \c 使匹配忽略大小写
  command = "set filetype=markdown",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local wk = require("which-key")
    wk.register({ ["<localleader>1"] = { ":MarkdownPreview<CR>", "Markdown preview" } },
                { buffer = vim.api.nvim_get_current_buf(), noremap = true })
  end,
})
