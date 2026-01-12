local M = {}

M.setup = function()
  local dap = require("dap")

  -- js-debug-adapter adapters are configured by mason-nvim-dap
  -- We just need to add configurations

  -- TypeScript/JavaScript configurations
  for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file with arguments",
        program = "${file}",
        cwd = "${workspaceFolder}",
        args = function()
          local args_string = vim.fn.input("Arguments: ")
          return vim.split(args_string, " ")
        end,
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to Node process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch Chrome to debug client",
        url = function()
          local url = vim.fn.input("Enter URL: ", "http://localhost:3000")
          return url
        end,
        webRoot = "${workspaceFolder}",
        protocol = "inspector",
        sourceMaps = true,
        userDataDir = false,
      },
      {
        type = "pwa-chrome",
        request = "attach",
        name = "Attach to Chrome",
        port = function()
          local port = vim.fn.input("Enter port: ", "9222")
          return tonumber(port)
        end,
        webRoot = "${workspaceFolder}",
        protocol = "inspector",
        sourceMaps = true,
      },
    }
  end

  -- TypeScript configurations with sourcemaps
  dap.configurations.typescriptreact = dap.configurations.typescript
  dap.configurations.javascriptreact = dap.configurations.javascript
end

return M
