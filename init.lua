vim.pack.add {
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
    { src = 'https://github.com/gbprod/nord.nvim' },
    { src = 'https://github.com/folke/which-key.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
}

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 4

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
    ensure_installed = {
        "lua_ls",
    }
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

require('nord').setup({
    transparent = true,
    terminal_colors = true,
})
vim.cmd.colorscheme("nord")

require('telescope').setup({
    defaults = {
      layout_strategy = "horizontal",
    },
    pickers = {
      find_files = { theme = "dropdown", previewer = false },
      oldfiles = { theme = "dropdown", previewer = false },
      buffers = { theme = "dropdown", previewer = false },
    },
  })

local builtin = require("telescope.builtin")

-- Grouped under <leader>f -> "Find"
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy Current Buffer" })
vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Grep Word Under Cursor" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })

-- [e] Explorer
vim.keymap.set("n", "<leader>e", "<cmd>Explore<cr>", { desc = "File Explorer (netrw)" })
vim.keymap.set("n", "<leader>es", "<cmd>Sexplore<cr>", { desc = "Explorer Horizontal Split" })
vim.keymap.set("n", "<leader>ev", "<cmd>Vexplore<cr>", { desc = "Explorer Vertical Split" })

-- [b] Buffer
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Force Delete Buffer" })

-- [w] Window / Split
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close Window" })
vim.keymap.set("n", "<leader>wo", "<cmd>only<cr>", { desc = "Close Other Windows" })

-- [q] Quit
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>qQ", "<cmd>q!<cr>", { desc = "Force Quit" })
vim.keymap.set("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit All" })

-- [s] Save
vim.keymap.set("n", "<leader>ss", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set("n", "<leader>sS", "<cmd>wa<cr>", { desc = "Save All" })

-- [h] Highlight / Help
vim.keymap.set("n", "<leader>hh", "<cmd>nohlsearch<cr>", { desc = "Clear Highlights" })

-- [d] Delete to void register (don't overwrite clipboard)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to Void" })

-- [p] Paste without yanking replaced text
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste Without Yank" })

-- [x] Quick fix / diagnostics (placeholder group)
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist, { desc = "Diagnostic List" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Down Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Up Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Keep cursor centered when scrolling / searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

local wk = require('which-key')
wk.add({
    { "<leader>b", group = "Buffer" },
    { "<leader>e", group = "Explorer" },
    { "<leader>f", group = "Find (Telescope)" },
    { "<leader>w", group = "Window" },
    { "<leader>q", group = "Quit" },
    { "<leader>s", group = "Save" },
    { "<leader>h", group = "Help/Highlight" },
    { "<leader>d", group = "Void Delete" },
    { "<leader>x", group = "Diagnostics" },
})

