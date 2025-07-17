local config = require('lang.config')

local tsserver_config = {
  root_dir = config.lsp.util.root_pattern("yarn.lock", "lerna.json", ".git"),
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false

    local ts_utils = require("nvim-lsp-ts-utils")
    -- defaults
    ts_utils.setup {
        disable_commands = false,
        debug = false,
        enable_import_on_completion = false,
        import_on_completion_timeout = 5000,
        -- eslint
        eslint_bin = "eslint_d",
        eslint_args = {"-f", "json", "--stdin", "--stdin-filename", "$FILENAME"},
        eslint_enable_disable_comments = true,

        -- experimental settings!
        -- eslint diagnostics
        eslint_enable_diagnostics = false,
        eslint_diagnostics_debounce = 250,
        -- formatting
        enable_formatting = false,
        formatter = "prettier",
        formatter_args = {"--stdin-filepath", "$FILENAME"},
        format_on_save = false,
        no_save_after_format = false,
        -- parentheses completion
        complete_parens = false,
        signature_help_in_parens = false,
        update_imports_on_move = true,
        require_confirmation_on_move = true,
        watch_dir = "./"
    }

    -- required to enable ESLint code actions and formatting
    ts_utils.setup_client(client)
    config.default_on_attach(client, bufnr)

    -- no default maps, so you may want to define some here
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", {silent = true})
  end
}

config.lsp.ts_ls.setup(config.merge(tsserver_config))
