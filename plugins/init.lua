return {
  ["github/copilot.vim"] = {},
  ["mfussenegger/nvim-dap"] = {},
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["theHamsta/nvim-dap-virtual-text"] = {
    config = function ()
      require("nvim-dap-virtual-text").setup()
    end
  },
  ["rcarriga/nvim-dap-ui"] = {
    config = function ()
      require("dapui").setup()
    end
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
  ["ThePrimeagen/harpoon"] = {},
  ["jose-elias-alvarez/null-ls.nvim"] = {
        after = "nvim-lspconfig",
        config = function()
           require "custom.plugins.null-ls"
        end,
  }
}

