local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('jotrorox.settings')
load('jotrorox.commands')
load('jotrorox.keymaps')
require('jotrorox.plugins')

pcall(vim.cmd.colorscheme, 'gruvbox')
