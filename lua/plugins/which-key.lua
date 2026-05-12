return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 250,
      icons = {
        mappings = true,
      },
      spec = {
        { "<leader>b", group = "buffers" },
        { "<leader>c", group = "code" },
        { "<leader>d", group = "delete" },
        { "<leader>e", group = "explorer" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "highlight" },
        { "<leader>q", group = "quit/session" },
        { "<leader>s", group = "save/search" },
        { "<leader>t", group = "terminal" },
        { "<leader>w", group = "windows" },
        { "<leader>x", group = "diagnostics" },
      },
    },
  },
}
