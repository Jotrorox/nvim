-- Themes
return {
	"folke/tokyonight.nvim",
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = {
			transparent_mode = true,
			terminal_colors = true,
		},
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {"gruvbox", "tokyonight",},
			})
		end
	}
}
