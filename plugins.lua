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
  {
    'NeogitOrg/neogit',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    cmd = "Neogit",
    config = function()
      require("neogit").setup({
       kind = "split", -- opens neogit in a split 
       signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
       },
       integrations = { diffview = true, telescope = true },
      })
     end
  },
  { 'lewis6991/gitsigns.nvim' },
  {
    'sindrets/diffview.nvim',
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    requires = 'nvim-lua/plenary.nvim'
  },
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
  },
  {
    'stevearc/oil.nvim',
  },
  {
    'emmanueltouzery/agitator.nvim',
    keys = {
      {
        "<leader>gkb", function()
          require('agitator').git_blame()
        end
      }
    },
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --     event = "VeryLazy",
  --     config = function()
  --       require("chatgpt").setup({
  --       api_key_cmd = "pass show api/tokens/openia/chatgpt.nvim_key"
  --     })
  --     end,
  --     dependencies = {
  --       "MunifTanjim/nui.nvim",
  --       "nvim-lua/plenary.nvim",
  --       "nvim-telescope/telescope.nvim"
  --     }
  -- },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
  },
  {
    "IndianBoy42/tree-sitter-just",
    config = function()
      require('tree-sitter-just').setup()
    end
  },
  {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end,
    lazy = false,
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    lazy = false,
    config = function ()
      require("git-worktree").setup()
      require("telescope").load_extension('git_worktree')
    end
  }
}

return plugins

