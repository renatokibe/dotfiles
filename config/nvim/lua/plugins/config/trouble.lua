local M = {}

M.setup = function()
  require("trouble").setup({
    -- Auto-detect ripgrep, but you can set explicit path if needed
    -- If ripgrep still not found, uncomment and set path:
    -- modes = {
    --   todo = {
    --     params = {
    --       rg_cmd = "/opt/homebrew/bin/rg", -- Adjust this path if needed
    --     },
    --   },
    -- },
  })
end

return M
