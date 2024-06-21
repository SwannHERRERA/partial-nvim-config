local M = {}

M.ui = {
  theme = 'solarized_light',
  tabufline = {
    show_numbers = false,
    enabled = false,
    lazyload = true,
    overriden_modules = nil,
  },
  statusline = {
    enabled = false,
  },
}

M.plugins = 'custom.plugins'
M.mappings = require "custom.mappings"

return M
