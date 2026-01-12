local M = {}

function M.setup()
  require("mason").setup({
    ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
    }
  })

  local options = {
    ensure_installed = {
      'lua_ls', 'omnisharp', 'phpactor', 'ts_ls', 'jdtls', 'dockerls', 'efm', 'solargraph', 'jedi_language_server', 'gopls'
    },
    automatic_enable = false
  }

  require("mason-lspconfig").setup(options)
end

return M
