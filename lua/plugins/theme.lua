return {
	{ 
		"catppuccin/nvim", 
		name = "catppuccin", 
		priority = 1000, 
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = false, -- disables setting the background color.
            })
            vim.cmd.colorscheme("catppuccin")
        end,
	}
}
