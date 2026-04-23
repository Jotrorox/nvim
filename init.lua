vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/gbprod/nord.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },

  -- completion
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-cmdline" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
})

-- Options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Theme
require("nord").setup({
  transparent = true,
  terminal_colors = true,
})
vim.cmd.colorscheme("nord")

-- LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
})

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
  automatic_enable = true,
})

-- Completion
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
})

-- Telescope
require("telescope").setup({
  defaults = {
    layout_strategy = "horizontal",
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = {
      "node_modules",
      ".git",
      "dist",
      "build",
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
})

local builtin = require("telescope.builtin")

-- Leader groups
vim.keymap.set("n", "<leader>f", "<nop>", { desc = "Find" })
vim.keymap.set("n", "<leader>b", "<nop>", { desc = "Buffer" })
vim.keymap.set("n", "<leader>w", "<nop>", { desc = "Window" })
vim.keymap.set("n", "<leader>q", "<nop>", { desc = "Quit" })
vim.keymap.set("n", "<leader>s", "<nop>", { desc = "Save" })
vim.keymap.set("n", "<leader>h", "<nop>", { desc = "Help / Highlight" })
vim.keymap.set("n", "<leader>d", "<nop>", { desc = "Void Delete" })
vim.keymap.set("n", "<leader>x", "<nop>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>e", "<nop>", { desc = "Explorer" })

-- Telescope
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
vim.keymap.set(
  "n",
  "<leader>fc",
  builtin.current_buffer_fuzzy_find,
  { desc = "Fuzzy Current Buffer" }
)
vim.keymap.set(
  "n",
  "<leader>fs",
  builtin.grep_string,
  { desc = "Grep Word Under Cursor" }
)
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })

-- Explorer
vim.keymap.set("n", "<leader>ee", "<cmd>Explore<cr>", { desc = "File Explorer" })
vim.keymap.set("n", "<leader>es", "<cmd>Sexplore<cr>", {
  desc = "Explorer Horizontal Split",
})
vim.keymap.set("n", "<leader>ev", "<cmd>Vexplore<cr>", {
  desc = "Explorer Vertical Split",
})

-- Buffers
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", {
  desc = "Previous Buffer",
})
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>bdelete!<cr>", {
  desc = "Force Delete Buffer",
})

-- Windows
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close Window" })
vim.keymap.set("n", "<leader>wo", "<cmd>only<cr>", {
  desc = "Close Other Windows",
})

-- Quit
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>qQ", "<cmd>q!<cr>", { desc = "Force Quit" })
vim.keymap.set("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit All" })

-- Save
vim.keymap.set("n", "<leader>ss", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set("n", "<leader>sS", "<cmd>wa<cr>", { desc = "Save All" })

-- Highlight
vim.keymap.set("n", "<leader>hh", "<cmd>nohlsearch<cr>", {
  desc = "Clear Highlights",
})

-- Void register delete / paste
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to Void" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste Without Yank" })

-- Diagnostics
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist, {
  desc = "Diagnostic List",
})

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Down Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Up Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Keep cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- which-key
local wk = require("which-key")
wk.add({
  { "<leader>b", group = "Buffer" },
  { "<leader>e", group = "Explorer" },
  { "<leader>f", group = "Find" },
  { "<leader>w", group = "Window" },
  { "<leader>q", group = "Quit" },
  { "<leader>s", group = "Save" },
  { "<leader>h", group = "Help / Highlight" },
  { "<leader>d", group = "Void Delete" },
  { "<leader>x", group = "Diagnostics" },
})
