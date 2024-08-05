local on_attach = require('lang.on_attach')
local lspconfig = require('lspconfig')
local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local Config = {}
Config.capabilities = vim.tbl_deep_extend('force', default_capabilities, cmp_capabilities)
Config.lsp = lspconfig
Config.default_on_attach = on_attach
Config.default_lsp = {
    on_attach = Config.default_on_attach,
    capabilities = Config.capabilities
}

Config.merge = function(config)
  return vim.tbl_deep_extend("force", Config.default_lsp, config)
end

return Config;
