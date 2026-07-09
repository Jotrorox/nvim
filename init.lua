-- Bootstrap mini.nvim so mini.deps can manage the rest.
local path_package = vim.fn.stdpath("data") .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.nvim"

if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing mini.nvim" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/nvim-mini/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed mini.nvim" | redraw')
end

require("mini.deps").setup({ path = { package = path_package } })

local add = MiniDeps.add
local now = MiniDeps.now
local later = MiniDeps.later

-- Basics
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Keep filetype-specific indentation, but default to 4 spaces everywhere else.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
  end,
})

-- Small, useful mappings
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Write file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Move to right window" })

now(function()
  add({ source = "catppuccin/nvim", name = "catppuccin" })

  require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    integrations = {
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    },
  })

  vim.cmd.colorscheme("catppuccin")
end)

now(function()
  require("mini.icons").setup()
  MiniIcons.mock_nvim_web_devicons()
end)

now(function()
  require("mini.statusline").setup({
    use_icons = vim.g.have_nerd_font ~= false,
  })
end)

later(function()
  require("mini.ai").setup()
  require("mini.comment").setup()
  require("mini.pairs").setup()
  require("mini.surround").setup()
end)
