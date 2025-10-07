local config = require('lang.config')

local Solargraph = {
  config = {

  }
}
local M = {
  config = {
  }
}

function M.setup()
  config.lsp.solargraph.setup(config.default_lsp)
end

return M
