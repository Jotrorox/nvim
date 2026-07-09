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
vim.opt.hidden = true
vim.opt.confirm = true
vim.opt.inccommand = "split"
vim.opt.completeopt = "menuone,noselect,popup"

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

local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
end

-- Small, useful mappings
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")
map("n", "<leader>w", "<cmd>write<CR>", "Write file")
map("n", "<leader>q", "<cmd>quit<CR>", "Quit window")
map("n", "<leader>x", "<cmd>bdelete<CR>", "Close buffer")
map("n", "<leader>h", "<C-w>h", "Move to left window")
map("n", "<leader>j", "<C-w>j", "Move to lower window")
map("n", "<leader>k", "<C-w>k", "Move to upper window")
map("n", "<leader>l", "<C-w>l", "Move to right window")
map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic")
map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")

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
  add({ source = "folke/which-key.nvim" })

  local wk = require("which-key")

  wk.setup({
    delay = 250,
    preset = "classic",
    icons = {
      mappings = vim.g.have_nerd_font ~= false,
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
      wo = {
        winblend = 10,
      },
    },
    layout = {
      spacing = 4,
      width = {
        min = 20,
        max = 50,
      },
    },
  })

  wk.add({
    { "<leader>f", group = "find/files" },
    { "<leader>g", group = "git" },
    { "<leader>n", group = "notifications" },
    { "<leader>s", group = "start" },
    { "<leader>?", function()
      wk.show({ global = false })
    end, desc = "Buffer local keymaps" },
  })
end)

now(function()
  local notify = require("mini.notify")

  notify.setup({
    lsp_progress = {
      enable = true,
      duration_last = 1500,
    },
    window = {
      config = {
        border = "rounded",
        anchor = "NE",
      },
      max_width_share = 0.45,
      winblend = 15,
    },
  })

  vim.notify = notify.make_notify()

  map("n", "<leader>nh", function()
    MiniNotify.show_history()
  end, "Notification history")

  map("n", "<leader>nc", function()
    MiniNotify.clear()
  end, "Clear notifications")
end)

now(function()
  local pick = require("mini.pick")

  pick.setup({
    mappings = {
      caret_left = "<Left>",
      caret_right = "<Right>",
      choose = "<CR>",
      choose_in_split = "<C-s>",
      choose_in_tabpage = "<C-t>",
      choose_in_vsplit = "<C-v>",
      choose_marked = "<M-CR>",
      delete_char = "<BS>",
      delete_char_right = "<Del>",
      delete_left = "<C-u>",
      delete_word = "<C-w>",
      mark = "<C-x>",
      mark_all = "<C-a>",
      move_down = "<C-n>",
      move_start = "<C-g>",
      move_up = "<C-p>",
      paste = "<C-r>",
      refine = "<C-Space>",
      refine_marked = "<M-Space>",
      scroll_down = "<C-f>",
      scroll_left = "<C-h>",
      scroll_right = "<C-l>",
      scroll_up = "<C-b>",
      stop = "<Esc>",
      toggle_info = "<F1>",
      toggle_preview = "<Tab>",
    },
    options = {
      use_cache = true,
    },
    window = {
      config = function()
        local height = math.floor(0.75 * vim.o.lines)
        local width = math.floor(0.75 * vim.o.columns)
        return {
          anchor = "NW",
          border = "rounded",
          height = height,
          width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        }
      end,
      prompt_prefix = "Pick: ",
    },
  })

  map("n", "<leader>ff", function()
    MiniPick.builtin.files()
  end, "Find files")
  map("n", "<leader>fg", function()
    MiniPick.builtin.grep_live()
  end, "Live grep")
  map("n", "<leader>fG", function()
    MiniPick.builtin.grep()
  end, "Grep pattern")
  map("n", "<leader>fb", function()
    MiniPick.builtin.buffers({ include_current = false })
  end, "Find buffers")
  map("n", "<leader>fh", function()
    MiniPick.builtin.help()
  end, "Find help")
  map("n", "<leader>fr", function()
    MiniPick.builtin.resume()
  end, "Resume picker")
  map("n", "<leader>f.", function()
    MiniPick.builtin.files(nil, { source = { cwd = vim.fn.expand("%:p:h") } })
  end, "Find files beside buffer")
end)

now(function()
  local files = require("mini.files")

  local show_dotfiles = true
  local filter_show = function()
    return true
  end
  local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
  end

  files.setup({
    mappings = {
      close = "q",
      go_in = "l",
      go_in_plus = "<CR>",
      go_out = "h",
      go_out_plus = "H",
      mark_goto = "'",
      mark_set = "m",
      reset = "<BS>",
      reveal_cwd = "@",
      show_help = "g?",
      synchronize = "s",
      trim_left = "<",
      trim_right = ">",
    },
    options = {
      permanent_delete = false,
      use_as_default_explorer = true,
    },
    windows = {
      max_number = 4,
      preview = true,
      width_focus = 35,
      width_nofocus = 18,
      width_preview = 70,
    },
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      vim.keymap.set("n", "g.", function()
        show_dotfiles = not show_dotfiles
        files.refresh({
          content = {
            filter = show_dotfiles and filter_show or filter_hide,
          },
        })
      end, { buffer = args.data.buf_id, desc = "Toggle dotfiles" })
    end,
  })

  local open_current = function(use_latest)
    local path = vim.api.nvim_buf_get_name(0)
    files.open(path ~= "" and path or nil, use_latest)
  end

  map("n", "-", function()
    if not files.close() then
      open_current(true)
    end
  end, "Toggle file explorer")

  map("n", "<leader>fo", function()
    files.open(nil, false)
  end, "Open file explorer")

  map("n", "<leader>fO", function()
    open_current(false)
  end, "Open explorer beside buffer")
end)

now(function()
  local starter = require("mini.starter")

  local pick_items = {
    { action = "Pick files", name = "Files", section = "Pick" },
    { action = "Pick grep_live", name = "Grep live", section = "Pick" },
    { action = "Pick help", name = "Help tags", section = "Pick" },
  }

  starter.setup({
    evaluate_single = true,
    items = {
      starter.sections.builtin_actions(),
      pick_items,
      starter.sections.recent_files(8, true, false),
      starter.sections.recent_files(8, false, true),
    },
    header = table.concat({
      "Neovim",
      "",
      "Space is leader. Type a prefix or use arrows, then Enter.",
    }, "\n"),
    footer = "",
    content_hooks = {
      starter.gen_hook.adding_bullet("  "),
      starter.gen_hook.indexing("section"),
      starter.gen_hook.padding(3, 2),
    },
  })

  map("n", "<leader>ss", function()
    MiniStarter.open()
  end, "Start screen")
end)

now(function()
  require("mini.statusline").setup({
    use_icons = vim.g.have_nerd_font ~= false,
  })
end)

later(function()
  require("mini.ai").setup()
  require("mini.comment").setup()
  require("mini.git").setup({
    command = {
      split = "vertical",
    },
  })
  require("mini.pairs").setup()
  require("mini.surround").setup()

  map("n", "<leader>gs", "<cmd>Git status<CR>", "Git status")
  map("n", "<leader>gl", "<cmd>Git log --oneline --decorate --graph --all -n 256<CR>", "Git log")
  map("n", "<leader>gb", "<cmd>Git blame -- %<CR>", "Git blame file")
  map("n", "<leader>gc", "<cmd>Git commit<CR>", "Git commit")
  map("n", "<leader>gp", "<cmd>Git push<CR>", "Git push")
  map("n", "<leader>gP", "<cmd>Git pull --ff-only<CR>", "Git pull")
  map("n", "<leader>go", function()
    MiniGit.show_at_cursor()
  end, "Git object at cursor")
  map({ "n", "x" }, "<leader>gH", function()
    MiniGit.show_range_history()
  end, "Git range history")
  map("n", "<leader>gd", function()
    MiniGit.show_diff_source()
  end, "Git diff source")
end)
