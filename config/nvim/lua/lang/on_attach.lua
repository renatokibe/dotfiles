return function(client, bufnr)
    require'lsp_signature'.on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window = true,
        handler_opts = {border = "single"}
    })
    require'illuminate'.on_attach(client)

    -- display lsp saga popup with diagnostic information
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'line',
        }

        vim.diagnostic.open_float(nil, opts)
      end
    })


    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings.
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>lgd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
    vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    vim.keymap.set('n', '<leader>llw', 'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))', opts)
    vim.keymap.set('n', '<leader>law', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>lrw', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>lrn', '<cmd>Lspsaga rename<CR>', opts)
    vim.keymap.set('n', '<leader>lrf', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
    vim.keymap.set('n', '<leader>ll', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<leader>lca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>ls', vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
end
