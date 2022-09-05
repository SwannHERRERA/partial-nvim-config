-- custom.plugins.lspconfig
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local configs = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "clangd",
  "tsserver",
  "eslint",
  "rust_analyzer",
  "jdtls",
  "sqls",
  "svelte",
  "pyright",
  "intelephense",
  "jsonls",
  "cucumber_language_server"
}

for _, lsp in ipairs(servers) do
  configs[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
