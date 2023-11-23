---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- telescope
    ["<leader>wo"] = { "<cmd> Telescope workspaces <CR>", "workspaces" },
    ["<leader>ts"] = { "<cmd> Telescope treesitter <CR>", "treesitter" },
    ["<leader>od"] = { "<cmd> Telescope lsp_document_symbols <CR>", "document symbols" },
    ["<leader>st"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "workspaces symbols" },
    ["<leader>gr"] = { "<cmd> Telescope lsp_references <CR>", "go to reference" },
    ["<leader>gi"] = { "<cmd> Telescope lsp_implementation <CR>", "go to implemetation" },
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

    -- Undo manager
    ["<leader>u"] = { "<cmd>Telescope undo<cr>", "Telescope undo" },
    -- Neogit
    ["<leader>p"] = { "<cmd>Neogit<cr>", "Open Neogit" }
  },
}

-- more keybinds!

return M
