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
		"shaunsingh/nord.nvim",
		priority = 1000,
		config = function ()
			vim.g.nord_disable_background = true
		end
	},
	"navarasu/onedark.nvim"
}
