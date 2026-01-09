local on_attach = require('lang.on_attach')
local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local Config = {}
Config.capabilities = vim.tbl_deep_extend('force', default_capabilities, cmp_capabilities)
Config.default_on_attach = on_attach
Config.default_lsp = {
    on_attach = Config.default_on_attach,
    capabilities = Config.capabilities
}

-- Helper to merge config with defaults
Config.merge = function(config)
  return vim.tbl_deep_extend("force", Config.default_lsp, config)
end

-- Configure and enable an LSP server using the new vim.lsp.config API
Config.setup = function(server_name, config)
  local merged_config = Config.merge(config or {})
  vim.lsp.config(server_name, merged_config)
  vim.lsp.enable(server_name)
end

return Config
