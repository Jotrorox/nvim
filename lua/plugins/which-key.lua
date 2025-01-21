return {
	{
		"folke/which-key.nvim",
		dependencies = {
			{ 'echasnovski/mini.icons', version = false },
		},
		config = function()
			local wk = require("which-key")
			wk.setup()
		end
	}
}
