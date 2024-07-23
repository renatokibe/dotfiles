local prettier = require("lang/diagnostics/prettier")
local eslint = require("lang/diagnostics/eslint")
local autopep8 = require("lang/diagnostics/autopep8")
local luafmt = require("lang/diagnostics/luafmt")
local rubocop = require("lang/diagnostics/rubocop")
local dart_formatter = require("lang/diagnostics/dart_formatter")
local on_attach = require("lang/on_attach")
local config = require('lang.config')

local languages = {
    lua = {luafmt},
    typescript = {prettier, eslint},
    javascript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    yaml = {prettier},
    json = {prettier},
    html = {prettier},
    scss = {prettier},
    css = {prettier},
    markdown = {prettier},
    python = {autopep8},
    ruby = {rubocop},
    dart = {dart_formatter}
}

local efm_config = {
    root_dir = config.lsp.util.root_pattern("yarn.lock", "lerna.json", ".git"),
    filetypes = vim.tbl_keys(languages),
    init_options = {documentFormatting = true, codeAction = true},
    settings = {languages = languages, log_level = 1, log_file = '~/efm.log'},
    on_attach = function (client, bufnr)
      client.server_capabilities.renameProvider = false
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.completionProvider = false
      on_attach(client, bufnr)
    end
}

config.lsp.efm.setup(config.merge(efm_config))
