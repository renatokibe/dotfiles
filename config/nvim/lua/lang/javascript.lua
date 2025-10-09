local config = require('lang.config')

local tsserver_config = {
  root_dir = config.lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  on_attach = function(client, bufnr)
    -- Disable tsserver formatting, prefer using prettier or eslint
    client.server_capabilities.documentFormattingProvider = false

    config.default_on_attach(client, bufnr)

    -- TypeScript specific keymaps
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gs", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

    -- Organize imports is now built into ts_ls
    vim.keymap.set("n", "gi", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.organizeImports" },
        },
      })
    end, vim.tbl_extend("force", opts, { desc = "Organize imports" }))

    -- Add missing imports
    vim.keymap.set("n", "gI", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.addMissingImports.ts" },
        },
      })
    end, vim.tbl_extend("force", opts, { desc = "Add missing imports" }))
  end,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

config.lsp.ts_ls.setup(config.merge(tsserver_config))
