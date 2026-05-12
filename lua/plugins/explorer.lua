return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ee", "<cmd>Neotree toggle reveal left<cr>", desc = "Toggle explorer" },
      { "<leader>ef", "<cmd>Neotree focus reveal left<cr>", desc = "Focus explorer" },
      { "<leader>eg", "<cmd>Neotree git_status float<cr>", desc = "Git status explorer" },
      { "<leader>eb", "<cmd>Neotree buffers float<cr>", desc = "Buffer explorer" },
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "NC",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },
      window = {
        width = 32,
        mappings = {
          ["<space>"] = "none",
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
    },
  },
}
