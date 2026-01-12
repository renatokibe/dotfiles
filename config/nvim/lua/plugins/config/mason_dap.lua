local M = {}

M.setup = function()
  require("mason-nvim-dap").setup({
    -- Ensure these debug adapters are installed
    ensure_installed = {
      "debugpy",          -- Python
      "js-debug-adapter", -- TypeScript/JavaScript/Node
      "delve",            -- Go
    },

    -- Automatically set up adapters for installed debug adapters
    automatic_setup = true,

    -- Automatic installation is enabled by default
    automatic_installation = true,

    -- Handlers for automatic adapter configuration
    handlers = {
      function(config)
        -- Default handler - applies to all debug adapters without a dedicated handler
        require("mason-nvim-dap").default_setup(config)
      end,

      -- Python debugpy handler
      python = function(config)
        config.adapters = {
          type = "executable",
          command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
          args = { "-m", "debugpy.adapter" },
        }
        require("mason-nvim-dap").default_setup(config)
      end,

      -- Note: js-debug-adapter and delve use default handler
      -- Custom configurations for Ruby, Python, Node, and Go
      -- are defined in their respective lang/debuggers/*.lua files
    },
  })
end

return M
