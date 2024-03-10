-- Themes
return {
	"typicode/bg.nvim",

	"ellisonleao/gruvbox.nvim",

	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
			})
		end,
	},

	{
		"rose-pine/nvim",
		name = "rose-pine",
	},

	"sainnhe/everforest",

	"savq/melange-nvim"
}
