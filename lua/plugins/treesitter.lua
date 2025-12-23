--[[
  File: treesitter.lua
  Description: Configuration of tree-sitter
  See: https://github.com/tree-sitter/tree-sitter
]]

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
  end
}
