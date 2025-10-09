local M = {}

M.setup = function()
  local treesitter = require('nvim-treesitter.configs')

  treesitter.setup {
    ensure_installed = 'all',
    ignore_install = { "ipkg", "blueprint", "fusion", "jsonc", "t32" },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    textsubjects = {
      enable = true,
      keymaps = {
        [';'] = 'textsubjects-smart',
        ['m'] = 'textsubjects-big',
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function"
        }
      }
    },
    -- tool to check treesider tree and its node names
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?'
      }
    },
    -- autopairs using treesitter
    autopairs = { enable = true },
    -- autopairs behavior for tags
    autotag = { enable = true },
    -- improved match for %
    matchup = {
      enable = true -- mandatory, false will disable the whole extension
    },
  }

  -- context aware (for languages that can embbed templates) commentstring
  -- (to use with vim-commentary and such)
  require('ts_context_commentstring').setup {
    enable_autocmd = false,
    languages = {
      typescript = '// %s',
      -- configuration for jsx and tsx
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      }
    },
  }

  require("nvim-treesitter.install").prefer_git = true

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.cmd('autocmd FileType ruby setlocal indentkeys-=.')
end

return M
