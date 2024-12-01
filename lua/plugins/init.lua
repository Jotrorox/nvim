local Plugins = {
  {'tpope/vim-fugitive'},
  {'wellle/targets.vim'},
  {'tpope/vim-repeat'},
  {'kyazdani42/nvim-web-devicons', lazy = true},
  {'numToStr/Comment.nvim', config = true, event = 'VeryLazy'},

  -- Themes
	{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...}
}

return Plugins
