local M = {}

M.setup = function()
  require('colorizer').setup({
    '*'; -- Highlight all files, but customize some others.
    css = { rgb_fn = true; };
    html = {
      mode = 'background'
    }
  })
end

return M
