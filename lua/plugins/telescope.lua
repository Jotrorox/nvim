return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in buffer" },
      { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep word" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" },
      { "<leader>fl", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.9,
          height = 0.85,
        },
        file_ignore_patterns = {
          ".git/",
          "node_modules/",
          "dist/",
          "build/",
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
        },
        oldfiles = {
          theme = "dropdown",
          previewer = false,
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
        },
      },
    },
  },
}
