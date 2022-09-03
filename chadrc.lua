-- Chadrc overrides this file
local pluginConfs = require "custom.plugins.configs"
local M = {}

M.options = {
  nvChad = {
    update_url = "https://github.com/NvChad/NvChad",
    update_branch = "main",
  },
}

M.ui = {
  theme_toggle = { "onedark", "one_light" },
  theme = "tokyodark",
  transparency = false,
}

M.plugins = {
  override = {
    ["NvChad/ui"] = {
      tabufline = {
        enabled = false
      }
    },
    ["kyazdani42/nvim-tree.lua"] = pluginConfs.nvimtree,
  },
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    }
  },
  remove = {},
  user = require "custom.plugins.init",
}

M.mappings = require "custom.mappings"

return M
