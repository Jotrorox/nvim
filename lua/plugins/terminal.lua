return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Floating terminal" },
      { "<leader>th", "<cmd>ToggleTerm size=12 direction=horizontal<cr>", desc = "Horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical terminal" },
      { "<leader>tn", "<cmd>TermNew<cr>", desc = "New terminal" },
    },
    opts = {
      size = 14,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      float_opts = {
        border = "single",
        width = function()
          return math.floor(vim.o.columns * 0.85)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local map = vim.keymap.set
      local terminal_opts = { buffer = 0 }
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          map("t", "<esc>", [[<C-\><C-n>]], terminal_opts)
          map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], terminal_opts)
          map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], terminal_opts)
          map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], terminal_opts)
          map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], terminal_opts)
        end,
      })
    end,
  },
}
