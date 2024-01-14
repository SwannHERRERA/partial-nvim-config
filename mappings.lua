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
    -- debuggablility
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Toggle breakpoint" },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    },

    -- Neogit
    ["<leader>p"] = { "<cmd> Neogit <CR>", "Open Neogit" },

    -- Undo manager
    ["<leader>u"] = { "<cmd>Telescope undo<cr>", "Telescope undo" },

    -- Move tricks
    ['{'] = { '<cmd><c-u>execute "keepjumps norm! " . v:count1 . "{"<cr>' },
    ['}'] = { '<cmd><c-u>execute "keepjumps norm! " . v:count1 . "}"<cr>' },
    ['J'] = { "}" },
    ['K'] = { "{" },
    ['gJ'] = { "<cmd>join<cr>" },

    -- Gitsign
    ['<leader>hs'] = { function() require('gitsigns').stage_hunk() end },
    ['<leader>hr'] = { function() require('gitsigns').reset_hunk() end },
    ['<leader>hS'] = { function() require('gitsigns').stage_buffer() end },
    ['<leader>hp'] = { function() require('gitsigns').preview_hunk() end }

  },
}

-- more keybinds!

return M
