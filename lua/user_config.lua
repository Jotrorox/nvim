local M = {}

M.setup_sources = function(b)
	return {
		b.formatting.autopep8,
		b.code_actions.gitsigns,
    { name = "copilot" }
	}
end

M.mason_ensure_installed = {
	null_ls = {
		"stylua",
		"jq",
	},
	dap = {
		"python",
		"delve",
	},
}

M.formatting_servers = {
	["rust_analyzer"] = { "rust" },
	["lua_ls"] = { "lua" },
	["null_ls"] = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
}

M.options = {
	opt = {
		confirm = true,
	},
}

M.autocommands = {
	alpha_folding = true,
	treesitter_folds = true,
	trailing_whitespace = true,
	remember_file_state = true,
	session_saved_notification = true,
	css_colorizer = true,
	cmp = true,
}

M.enable_plugins = {
	aerial = true,
	alpha = true,
	autotag = true,
	bufferline = true,
	context = true,
	copilot = true,
	dressing = true,
	gitsigns = true,
	hop = true,
	img_clip = true,
	indent_blankline = true,
	lsp_zero = true,
	lualine = true,
	neodev = true,
	neoscroll = true,
	neotree = true,
	session_manager = true,
	noice = true,
	null_ls = true,
	autopairs = true,
	cmp = true,
	colorizer = true,
	dap = true,
	notify = true,
	surround = true,
	treesitter = true,
	ufo = true,
	onedark = false,
	project = true,
	rainbow = true,
	scope = true,
	telescope = true,
	toggleterm = true,
	trouble = true,
	twilight = true,
	whichkey = true,
	windline = true,
	zen = true,
}

M.plugins = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                integrations = {
                    aerial = true,
                    alpha = true,
                    bufferline = true,
                    cmp = true,
                    gitsigns = true,
                    mason = true,
                    neotree = true,
                    notify = true,
                    noice = true,
                    telescope = true,
                    treesitter = true,
                    which_key = true,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
            })
        end,
    },
    {
      "zbirenbaum/copilot-cmp",
      event = "InsertEnter",
      config = function () require("copilot_cmp").setup() end,
      dependencies = {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        config = function()
          require("copilot").setup({
            suggestion = {
              enabled = true,
              auto_trigger = true,
              debounce = 0,
            },
            panel = { enabled = false },
          })
        end,
      },
    },
}

M.lsp_config = {
	clangd = {},
}

return M
