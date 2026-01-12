local config = require('lang.config')

local gopls_config = {
  root_markers = {"go.mod", ".git"},
  on_attach = function(client, bufnr)
    config.default_on_attach(client, bufnr)

    -- Go specific keymaps
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Organize imports
    vim.keymap.set("n", "gi", function()
      local params = vim.lsp.util.make_range_params()
      params.context = { only = { "source.organizeImports" } }
      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
      for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
          else
            vim.lsp.buf.execute_command(r.command)
          end
        end
      end
    end, vim.tbl_extend("force", opts, { desc = "Organize imports" }))

    -- Fill struct
    vim.keymap.set("n", "gf", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "refactor.rewrite" },
        },
      })
    end, vim.tbl_extend("force", opts, { desc = "Fill struct" }))
  end,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}

config.setup('gopls', gopls_config)
