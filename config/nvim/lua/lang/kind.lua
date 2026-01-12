local lspkind = require('lspkind')

-- Custom source icons and names
local source_names = {
  copilot = "Copilot",
  nvim_lsp = "LSP",
  buffer = "Buffer",
  path = "Path",
  vsnip = "Snippet",
  cmdline = "Cmd",
  ["render-markdown"] = "Markdown",
}

local source_icons = {
  Copilot = ""
}


return lspkind.cmp_format({
    mode = 'symbol_text', -- show icon + type name
    maxwidth = 50,
    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    show_labelDetails = true, -- show labelDetails in menu. Disabled by default
    symbol_map = { source_icons }, -- Custom icon for Copilot

    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    before = function (entry, vim_item)
        -- Get the source name
        local source_name = entry.source.name

        -- Special handling for Copilot
        if source_name == "copilot" then
            vim_item.kind = "Copilot"
            vim_item.kind_hl_group = "CmpItemKindCopilot"

            -- Show better label instead of code snippet with ellipsis
            -- Replace the abbr with a cleaner description
            if vim_item.abbr and type(vim_item.abbr) == "string" then
                -- Keep first line only and truncate intelligently
                local first_line = vim_item.abbr:match("([^\n]*)")
                if first_line and #first_line > 50 then
                    vim_item.abbr = first_line:sub(1, 47) .. "..."
                else
                    vim_item.abbr = first_line or vim_item.abbr
                end
            elseif vim_item.abbr and type(vim_item.abbr) ~= "string" then
                -- Ensure label is a string to avoid Blob errors
                vim_item.abbr = "AI Suggestion"
            end
        end

        return vim_item
    end
})
