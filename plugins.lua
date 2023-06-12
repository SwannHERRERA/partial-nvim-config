local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyser",
      },
    },
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    'saecki/crates.nvim',
    ft = {
      "rust",
      "toml"
    },
    config = function (_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function ()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  },
  {
    "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end,
      lazy = false,
  },
  {
    "ggandor/leap.nvim",
    lazy = false,
  },
  {
    "ggandor/flit.nvim",
    dependencies = "ggandor/leap.nvim",
    lazy = false,
    config = function ()
      require('flit').setup {
        keys = { f = 'f', F = 'F', t = 't', T = 'T' },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "v",
        multiline = true,
        -- Like `leap`s similar argument (call-specific overrides).
        -- E.g.: opts = { equivalence_classes = {} }
        opts = {}
      }
    end
  },
  {
    "natecraddock/workspaces.nvim",
    lazy = false,
    config = function ()
      require("workspaces").setup({
        hook = {
          open = "Telecope find_files",
        }
      })
      require('telescope').load_extension("workspaces")
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "natecraddock/workspaces.nvim",
    },
    init = function()
      require("core.utils").load_mappings "telescope"
    end,

    opts = function()
      return require "plugins.configs.telescope"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      opts.extensions = {
        undo = {
          use_delta = true
        }
      }
      telescope.setup(opts)

      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
      require("telescope").load_extension("undo")
    end,
  },
  { "zbirenbaum/copilot.lua", lazy = false },
  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  },
  { "tpope/vim-fugitive", lazy = false },
  { 'lewis6991/gitsigns.nvim' },
  { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' },
  {
    'ThePrimeagen/harpoon',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim'},
    keys = {
      {"<leader><leader>", function()	end },
      {"<leader>a", function() require('harpoon.mark').add_file() end},
      --	{"<C-e>", function() require('harpoon.ui').toggle_quick_menu() end},
      {"<leader>fe", function() require('harpoon.ui').toggle_quick_menu() end}
    },
    config = function ()
      require("harpoon").setup({
        menu = {
          width = vim.api.nvim_win_get_width(0)-4,
        }
      })
      require("telescope").load_extension('harpoon')
    end
  }
}

return plugins

