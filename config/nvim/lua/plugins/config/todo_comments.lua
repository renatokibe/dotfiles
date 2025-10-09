local M = {}

M.setup = function()
  require("todo-comments").setup({
    keywords = {
      TODO = { alt = {"WIP"} }
    }
  })
end

return M
