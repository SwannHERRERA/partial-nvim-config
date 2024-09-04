---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- telescope
    ["<leader>sh"] = { "<cmd> Telescope search_history <CR>", "Search History" },
    ["<leader>diag"] = { "<cmd> Telescope diagnostics <CR>", "Workspace Diagnostic" },
    ["<leader>re"] = { "<cmd> Telescope resume <CR>", "Resume Search" },
    ["<leader>wo"] = { "<cmd> Telescope workspaces <CR>", "workspaces" },
    ["<leader>ts"] = { "<cmd> Telescope treesitter <CR>", "treesitter" },
    ["<leader>od"] = { "<cmd> Telescope lsp_document_symbols <CR>", "document symbols" },
    ["<leader>st"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "workspaces symbols" },
    ["<leader>gr"] = { "<cmd> Telescope lsp_references <CR>", "go to reference" },
    ["<leader>gi"] = { "<cmd> Telescope lsp_implementation <CR>", "go to implemetation" },
    ["<leader>gf"] = { "<cmd> Telescope git_files <CR>", "Git files" },
    ["<leader>ss"] = { "<cmd> Telescope builtin <CR>", "Telescope telescope" },
    ["<leader>fr"] = { function() require("telescope").extensions.live_grep_args.live_grep_args() end },

    -- Neogit
    ["<leader>p"] = { "<cmd> Neogit <CR>", "Open Neogit" },

    -- Undo manager
    ["<leader>u"] = { "<cmd>Telescope undo<cr>", "Telescope undo" },

    -- Move tricks
    ['{'] = { '<cmd><c-u>execute "keepjumps norm! " . v:count1 . "{"<cr>' },
    ['}'] = { '<cmd><c-u>execute "keepjumps norm! " . v:count1 . "}"<cr>' },
    ['J'] = { "}" },
    -- ["<C-k>"] = {
    --   function()
    --     vim.lsp.buf.hover()
    --   end,
    --   "LSP hover",
    -- },
    -- ['K'] = { "{" },
    ['gJ'] = { "<cmd>join<cr>" },

    -- Gitsign
    ['<leader>hs'] = { function() require('gitsigns').stage_hunk() end },
    ['<leader>hr'] = { function() require('gitsigns').reset_hunk() end },
    ['<leader>hS'] = { function() require('gitsigns').stage_buffer() end },
    ['<leader>hp'] = { function() require('gitsigns').preview_hunk() end },

    -- Harpoon
    --
    --

    ['<leader>a'] = { function() require('harpoon'):list():add() end },
    ['L'] = { function() require('harpoon'):list():next() end },
    ['H'] = { function() require('harpoon'):list():prev() end },
    ['<C-t>'] = { function() require('harpoon'):list():select(1) end },
    ['<C-b>'] = { function() require('harpoon'):list():select(2) end },
    ["<leader>df"] = {
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end
    },
    ['<leader>fe'] = {
      function()
        local conf = require("telescope.config").values
        local harpoon = require('harpoon')
        local harpoon_files = harpoon:list()
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        }):find()
      end
    }
  },
}

-- debuggablility
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"},
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}
-- more keybinds!

return M
