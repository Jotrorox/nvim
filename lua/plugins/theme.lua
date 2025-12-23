--[[
  File: theme.lua
  Description: Configuration of my Theme - Catpuccin Mocha
  See: https://github.com/catppuccin/nvim
]]

return {
  "catppuccin/nvim", 
  name = "catppuccin", 
  priority = 1000,
  config = function ()
    require('catppuccin').setup({
      flavour = "mocha",
      transparent_background = true
    })

    vim.cmd.colorscheme "catppuccin"
  end
}
