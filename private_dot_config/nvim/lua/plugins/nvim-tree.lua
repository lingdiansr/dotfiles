return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      -- 你的 nvim-tree 配置
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    })
  end,
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
  },
}
