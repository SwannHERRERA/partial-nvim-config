return {
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
       require("better_escape").setup()
    end,
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
  },
  ["natecraddock/workspaces.nvim"] = {
    config = function ()
      require("workspaces").setup({
        hooks = {
          open = "NvimTreeOpen",
        }
      })
    end
  },
}

