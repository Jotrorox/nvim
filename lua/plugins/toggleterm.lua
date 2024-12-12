local Plugin = {'akinsho/toggleterm.nvim'}

Plugin.keys = {'<C-g>'}

-- See :help toggleterm-roadmap
Plugin.opts = {
	open_mapping = '<leader>th',
  direction = 'horizontal',
  shade_terminals = true
}

return Plugin
