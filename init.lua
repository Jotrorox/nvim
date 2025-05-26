-- Set <space> as the leader key (:help mapleader)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if using a Nerd Font
vim.g.have_nerd_font = true

-- [[ Options ]] (:help vim.opt, :help option-list)

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true -- Relative numbers for jumping

-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show mode (status line already shows it)
vim.opt.showmode = false

-- Sync clipboard with OS (:help 'clipboard')
-- Scheduled after UiEnter to improve startup time. Remove if independent clipboard is desired.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive search unless \C or capital letters used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn visible
vim.opt.signcolumn = "yes"

-- Decrease update time (faster updates)
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure new split locations
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tab and indent settings (4 spaces)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true -- Use spaces instead of tabs

-- Live preview substitutions
vim.opt.inccommand = "split"

-- Show cursor line
vim.opt.cursorline = true

-- Minimal lines above/below cursor
vim.opt.scrolloff = 10

-- Confirm dialog for unsaved changes (:help 'confirm')
vim.opt.confirm = true

-- [[ Basic Keymaps ]] (:help vim.keymap.set())

-- Clear search highlights with <Esc> (:help hlsearch)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Easier exit from terminal mode (<C-\><C-n> is default)
-- NOTE: May not work in all terminals/tmux.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode to encourage hjkl usage
vim.keymap.set("n", "<left>", '<cmd>echo "Use h!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j!"<CR>')

-- Easier split navigation with CTRL+<hjkl> (:help wincmd)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus left" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus right" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus down" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus up" })

-- [[ Basic Autocommands ]] (:help lua-guide-autocommands)

-- Highlight yanked text (:help vim.highlight.on_yank())
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Setting up languages not yet included in neovim
vim.filetype.add({
	extension = {
		c3 = "c3",
		c3i = "c3",
		c3t = "c3",
	},
})

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "c3" then
			vim.cmd("TSEnable highlight")
		end
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]] (:help lazy.nvim.txt)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
-- Check status: :Lazy | Update plugins: :Lazy update
require("lazy").setup({
	-- Detect tabstop/shiftwidth automatically
	-- "tpope/vim-sleuth",

	-- Git signs in the gutter and utilities
	{
		"lewis6991/gitsigns.nvim",
		opts = { -- See :help gitsigns-usage
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true,
			message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
			virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
		},
	},
	{
		"NeogitOrg/neogit",
		keys = {
			{ "<leader>gs", "<CMD>Neogit<CR>", desc = "[S]tatus" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
	},

	-- Shows pending keybinds
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			delay = 0, -- Delay before showing (ms)
			icons = {
				mappings = vim.g.have_nerd_font, -- Use Nerd Font icons if available
				keys = vim.g.have_nerd_font and {} or { -- Fallback icons if no Nerd Font
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},
			spec = { -- Document key chains
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- Native FZF sorter for performance
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make", -- Build command on install/update
				cond = function() -- Load only if 'make' is executable
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" }, -- UI selection theme
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- Icons (requires Nerd Font)
		},
		config = function()
			-- Configure Telescope (:help telescope, :help telescope.setup())
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- Keymaps (:help telescope.builtin)
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Fuzzy search in current buffer with dropdown theme
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- Live grep in open files
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Search Neovim config files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		opts = {},
		keys = {
			{
				"<leader>oi",
				function()
					require("oil").open()
				end,
				desc = "[O]pen [I]nfo",
			},
			{
				"<leader>oc",
				function()
					require("oil").close()
				end,
				desc = "[O]pen [C]lose",
			},
			{
				"<leader>ot",
				function()
					require("oil").toggle()
				end,
				desc = "[O]pen [T]oggle",
			},
		},
		dependencies = {
			{ "echasnovski/mini.icons", opts = {} },
			{ "nvim-tree/nvim-web-devicons", opts = {} },
		},
		lazy = false,
	},

	-- LSP Plugins
	{
		-- Lua LSP enhancements for Neovim config/runtime/plugins
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } }, -- Load luvit types for vim.uv
			},
		},
	},
	{
		-- Core LSP configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs & tools
			{ "williamboman/mason.nvim", opts = {} }, -- Must be setup before dependents
			"williamboman/mason-lspconfig.nvim", -- Bridges mason & lspconfig
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- Installs tools defined later

			{ "j-hui/fidget.nvim", opts = {} }, -- LSP status updates
			"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for LSP
		},
		config = function()
			-- LSP: Language Server Protocol (:help lsp)
			-- Provides features like go-to-definition, find-references, completion, etc.
			-- Requires external language servers (installed via Mason).
			-- See :help lsp-vs-treesitter for comparison.

			-- Runs on LSP attach to buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- Helper for LSP-specific keymaps
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- LSP Keymaps (using Telescope)
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Other LSP Keymaps
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration") -- Note: Declaration, not Definition

					-- Check if client supports a method (handles 0.10 vs 0.11 diff)
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					-- Highlight references under cursor on CursorHold
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						-- Clear highlights and autocommands on LspDetach
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Toggle inlay hints if supported
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic configuration (:help vim.diagnostic.config)
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font
						and { -- Nerd Font icons for signs
							text = {
								[vim.diagnostic.severity.ERROR] = "󰅚 ",
								[vim.diagnostic.severity.WARN] = "󰀪 ",
								[vim.diagnostic.severity.INFO] = "󰋽 ",
								[vim.diagnostic.severity.HINT] = "󰌶 ",
							},
						}
					or {},
				virtual_text = { -- Show message inline
					source = "if_many", -- Show only if multiple sources
					spacing = 2,
					format = function(diagnostic) -- Show only message text
						return diagnostic.message
					end,
				},
			})

			-- Add nvim-cmp capabilities to LSP client capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Configure LSP servers
			-- Add servers here. They will be automatically installed by Mason.
			-- See :help lspconfig-all for list.
			-- Add overrides in the table: cmd, filetypes, capabilities, settings
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							-- diagnostics = { disable = { 'missing-fields' } }, -- uncomment to disable 'missing-fields'
						},
					},
				},
			}

			-- Ensure servers and additional tools are installed via Mason
			-- Check status: :Mason
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Lua formatter
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- Setup servers via mason-lspconfig
			require("mason-lspconfig").setup({
				ensure_installed = {}, -- Installs handled by mason-tool-installer
				automatic_installation = false,
				handlers = {
					function(server_name) -- Default handler
						local server = servers[server_name] or {}
						-- Apply server-specific overrides and capabilities
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			require("lspconfig").gleam.setup(capabilities)

			local util = require("lspconfig/util")
			local configs = require("lspconfig.configs")
			if not configs.c3_lsp then
				configs.c3_lsp = {
					default_config = {
						cmd = { "/home/johannes/bin/c3lsp" },
						filetypes = { "c3", "c3i" },
						root_dir = function(fname)
							return util.find_git_ancestor(fname)
						end,
						settings = {},
						name = "c3_lsp",
					},
				}
			end
			require("lspconfig").c3_lsp.setup({})
		end,
	},

	{ -- Autoformatter
		"stevearc/conform.nvim",
		event = { "BufWritePre" }, -- Run on save
		cmd = { "ConformInfo" },
		keys = {
			{ -- Manual format keybind
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable format on save for specific filetypes (e.g., C/C++)
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return { timeout_ms = 500, lsp_format = "fallback" } -- Use LSP formatter as fallback
				end
			end,
			formatters_by_ft = { -- Specify formatters per filetype
				lua = { "stylua" },
				-- python = { "isort", "black" }, -- Multiple formatters run sequentially
				-- javascript = { "prettierd", "prettier", stop_after_first = true }, -- Run first available
			},
		},
	},

	{ -- Autocompletion engine
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet engine & source
			{
				"L3MON4D3/LuaSnip",
				build = (function() -- Build step for regex support (skip on Windows or if 'make' not found)
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- Premade snippets (optional)
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
					-- },
				},
			},
			"saadparwaiz1/cmp_luasnip", -- Luasnip completion source

			-- Other sources
			"hrsh7th/cmp-nvim-lsp", -- LSP source
			"hrsh7th/cmp-path", -- File path source
			"hrsh7th/cmp-nvim-lsp-signature-help", -- Signature help source
		},
		config = function()
			-- Configure nvim-cmp (:help cmp)
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({}) -- Basic Luasnip setup

			cmp.setup({
				snippet = { -- Configure snippet expansion
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" }, -- Completion options

				-- Keymappings (:help ins-completion)
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(), -- Select next item
					["<C-p>"] = cmp.mapping.select_prev_item(), -- Select previous item
					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs back
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll docs forward
					["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion (accept)
					["<C-Space>"] = cmp.mapping.complete({}), -- Manually trigger completion

					-- Snippet navigation
					["<C-l>"] = cmp.mapping(function() -- Jump forward in snippet
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function() -- Jump backward in snippet
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- Traditional keymaps (optional)
					--['<CR>'] = cmp.mapping.confirm { select = true },
					--['<Tab>'] = cmp.mapping.select_next_item(),
					--['<S-Tab>'] = cmp.mapping.select_prev_item(),
				}),
				sources = { -- Configure completion sources
					{ name = "lazydev", group_index = 0 }, -- Lua dev source (priority 0)
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "nvim_lsp_signature_help" },
				},
			})
		end,
	},

	-- AI Plugins
	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	-- 	config = function()
	-- 		require("supermaven-nvim").setup({
	--			keymaps = {
	--					accept_suggestion = "<Tab>",
	--				clear_suggestion = "<C-]>",
	--			accept_word = "<C-j>",
	--			},
	--			ignore_filetypes = {}, -- or { "cpp", }
	--			color = {
	--				suggestion_color = "#ffffff",
	--				cterm = 244,
	--			},
	--			log_level = "info", -- set to "off" to disable logging completely
	--			disable_inline_completion = false, -- disables inline completion for use with cmp
	--			disable_keymaps = false, -- disables built in keymaps for more manual control
	--			condition = function()
	--				return false
	--			end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
	--		})
	--	end,
	--},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},

	{ -- Colorscheme (Catppuccin)
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
			})
			-- Load the colorscheme
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Highlight TODO, NOTE, etc. in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false }, -- Disable signs
	},

	{ -- Collection of small useful plugins (mini.nvim)
		"echasnovski/mini.nvim",
		config = function()
			-- Better textobjects (e.g., va), yinq, ci')
			require("mini.ai").setup({ n_lines = 500 })
			-- Add/delete/replace surroundings (e.g., saiw), sd', sr)')
			require("mini.surround").setup()
			-- Simple statusline
			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })
			-- Customize statusline location section (LINE:COLUMN)
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
			-- Explore more modules: https://github.com/echasnovski/mini.nvim
		end,
	},

	-- Language specific plugins
	{ -- lilguys
		"stunwin/lilguys.nvim",
		config = function()
			require("lilguys").setup()
		end,
	},
	{
		"wstucco/c3.nvim",
		config = function()
			require("c3")
		end,
	},
	{ -- Better clojure/fennel support
		"Olical/conjure",
		ft = { "clojure", "fennel" },
		lazy = true,
		init = function() end,

		dependencies = { "PaterJason/cmp-conjure" },
	},
	{
		"PaterJason/cmp-conjure",
		lazy = true,
		config = function()
			local cmp = require("cmp")
			local config = cmp.get_config()
			table.insert(config.sources, { name = "conjure" })
			return cmp.setup(config)
		end,
	},

	{ -- Treesitter for syntax highlighting, indentation, etc.
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- Update parsers on install/update
		event = "BufRead",
		main = "nvim-treesitter.configs",
		opts = { -- (:help nvim-treesitter)
			ensure_installed = { -- Languages to install parsers for
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			auto_install = true, -- Automatically install missing parsers
			highlight = {
				enable = true,
				-- Use vim regex highlighting for languages with complex indent rules (e.g., ruby)
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } }, -- Disable TS indent for specific languages
		},
		config = function()
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.c3 = {
				install_info = {
					url = "https://github.com/c3lang/tree-sitter-c3",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "main",
				},
			}
			require("nvim-treesitter.install").update({ with_sync = true })
			require("nvim-treesitter").setup({ highlight = { enable = true } })
		end,
	},

	{ -- Hex editor integration
		"RaafatTurki/hex.nvim",
		keys = {
			{
				"<leader>ht",
				function()
					require("hex").toggle()
				end,
				mode = "n",
				desc = "[T]oggle Hex View",
			},
			{
				"<leader>hd",
				function()
					require("hex").dump()
				end,
				mode = "n",
				desc = "[D]ump (Switch to Hex)",
			},
			{
				"<leader>ha",
				function()
					require("hex").assemble()
				end,
				mode = "n",
				desc = "[A]ssemble (Switch to Normal)",
			},
		},
		config = function() end, -- No specific config needed here
	},

	-- Games
	{
		"ThePrimeagen/vim-be-good",
		lazy = true,
		cmd = "VimBeGood",
	},
	{
		"alec-gibson/nvim-tetris",
		lazy = true,
		cmd = "Tetris",
	},
}, {
	ui = { -- Configure lazy.nvim UI
		icons = vim.g.have_nerd_font and {} or { -- Use Nerd Font icons if available, else unicode
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- Modeline (:help modeline)
-- vim: ts=2 sts=2 sw=2 et
