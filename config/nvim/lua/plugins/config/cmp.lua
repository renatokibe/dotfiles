local M = {}

M.setup = function()
  -- Set up nvim-cmp.
  local cmp = require('cmp')
  local lsp_kind_format = require('lang.kind')

  -- Configure copilot-cmp with safe formatting
  local has_copilot_cmp, copilot_cmp = pcall(require, "copilot_cmp")
  if has_copilot_cmp then
    copilot_cmp.setup({
      fix_pairs = true,
    })
  end

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    -- window = {
    --   completion = {
    --     winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
    --   },
    --   documentation = {
    --     winhighlight = 'Normal:CmpPmenu',
    --   },
    -- },
    -- Preselect first item to show documentation immediately
    preselect = cmp.PreselectMode.Item,
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    -- Experimental: show ghost text for first suggestion
    -- experimental = {
    --   ghost_text = {
    --     hl_group = "comment",
    --   },
    -- },
    -- experimental = {
    --   -- only show ghost text when we show ai completions
    --   ghost_text = vim.g.ai_cmp and {
    --     hl_group = "CmpGhostText",
    --   } or false,
    -- },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      -- Tab to select next item
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      -- Shift-Tab to select previous item
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = "copilot", group_index = 2, max_item_count = 3 },
      { name = 'nvim_lsp', max_item_count = 20 },
      { name = 'vsnip', max_item_count = 5 }, -- For vsnip users.
      { name = 'render-markdown', max_item_count = 5 },
    }, {
      { name = 'buffer', max_item_count = 5 },
    }),

    formatting = { format = lsp_kind_format }
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]--

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
end

return M
