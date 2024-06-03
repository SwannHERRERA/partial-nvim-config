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
        "rust_analyser",
        "ruff",
        "mypy",
        "debugpy",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
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
      {"<leader>fe", function() require('harpoon.ui').toggle_quick_menu() end},
      {"L", function() require('harpoon.ui').nav_next() end},
      {"H", function() require('harpoon.ui').nav_prev() end}
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
  --   }
  -- },
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
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = true,
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        elixir = { 'credo' }
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "lua_ls" },
        javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
        typescript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {
    "vim-test/vim-test",
    config = function()
      vim.cmd([[
        function! BufferTermStrategy(cmd)
          exec 'te ' . a:cmd
        endfunction

        let g:test#custom_strategies = {'bufferterm': function('BufferTermStrategy')}
        let g:test#strategy = 'bufferterm'
      ]])
    end,
    keys = {
      { "<leader>Tf", "<cmd>TestFile<cr>",    silent = true, desc = "Run this file" },
      { "<leader>Tn", "<cmd>TestNearest<cr>", silent = true, desc = "Run nearest test" },
      { "<leader>Tl", "<cmd>TestLast<cr>",    silent = true, desc = "Run last test" },
    },
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
  },
  {
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = function()
        vim.fn["firenvim#install"](0)
    end
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equalent to setup({}) function
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {}
  },
  {
      'nvimdev/lspsaga.nvim',
      config = function()
          require('lspsaga').setup({})
      end,
      dependencies = {
          'nvim-treesitter/nvim-treesitter', -- optional
          'nvim-tree/nvim-web-devicons'     -- optional
      }
  },
  {
    'glepnir/galaxyline.nvim'
  },
  {
    'nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  {
  "dnlhc/glance.nvim",
    config = function()
      require('glance').setup({
        -- your configuration
      })
    end,
  },
  {
    'ruifm/gitlinker.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require"gitlinker".setup()
    end
  },
  {'akinsho/git-conflict.nvim', version = "*", config = true},
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
      require("telescope").load_extension("refactoring")
    end,
  },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require('treesj').setup({--[[ your config ]]})
    end,
  },
  {
      "smoka7/multicursors.nvim",
      event = "VeryLazy",
      dependencies = {
          'smoka7/hydra.nvim',
      },
      opts = {},
      cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
      keys = {
              {
                  mode = { 'v', 'n' },
                  '<Leader>m',
                  '<cmd>MCstart<cr>',
                  desc = 'Create a selection for selected text or word under the cursor',
              },
          },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async'
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  },
  { "chrisgrieser/nvim-spider", lazy = true },
  {
    "chrisgrieser/nvim-scissors",
    dependencies = { "nvim-telescope/telescope.nvim", "L3MON4D3/LuaSnip" },
    opts = {
      snippetDir = "path/to/your/snippetFolder",
    }
  },
  {
    'razak17/tailwind-fold.nvim',
    opts= {},
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade' },
  },
  {
      "MaximilianLloyd/tw-values.nvim",
      keys = {
          { "<leader>sv", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
      },
      opts = {
          border = "rounded", -- Valid window border style,
          show_unknown_classes = true, -- Shows the unknown classes popup
          focus_preview = true, -- Sets the preview as the current window
          copy_register = "", -- The register to copy values to,
          keymaps = {
              copy = "<C-y>"  -- Normal mode keymap to copy the CSS values between {}
          }
      }
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
    -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
    -- available after the first executing of it or after a keymap of text-case.nvim has been used.
    lazy = false,
  },
  {
    {
      'laytan/tailwind-sorter.nvim',
      dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim'},
      build = 'cd formatter && npm ci && npm run build',
      config = true,
    },
  },
}

return plugins

