lvim.plugins = {
  {
    "felipec/vim-sanegx",
    event = "BufRead",
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 0
    end,
  },
  { "LunarVim/Colorschemes" },
  { "folke/tokyonight.nvim" },
  { "pchaos/fcitx5-status" },
}
