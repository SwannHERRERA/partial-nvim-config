local config = require "custom.plugins.configs"

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
  },
  ["NTBBloodbath/rest.nvim"] = {
    requires = { "nvim-lua/plenary.nvim" },
    config = function ()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,

        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
          -- executables or functions for formatting response body [optional]
          -- set them to nil if you want to disable them
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
            end
          },
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end
  },
  ["scalameta/nvim-metals"] = {
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function ()
      require("metals").bare_config()
    end,
  },
  ["akinsho/flutter-tools.nvim"] = {
    config = function ()
      require("flutter-tools").setup{}
    end
  },
}

