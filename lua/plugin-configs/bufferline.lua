require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		separator_style = "thin",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	},
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})
