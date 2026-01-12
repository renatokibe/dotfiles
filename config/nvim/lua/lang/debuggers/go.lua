local M = {}

M.setup = function()
  local dap = require("dap")

  -- Delve adapter is configured by mason-nvim-dap
  -- We just need to add configurations

  dap.configurations.go = {
    {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "delve",
      name = "Debug with arguments",
      request = "launch",
      program = "${file}",
      args = function()
        local args_string = vim.fn.input("Arguments: ")
        return vim.split(args_string, " ")
      end,
    },
    {
      type = "delve",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    {
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
    {
      type = "delve",
      name = "Debug Package",
      request = "launch",
      program = "${workspaceFolder}",
    },
    {
      type = "delve",
      name = "Attach to process",
      mode = "local",
      request = "attach",
      processId = require("dap.utils").pick_process,
    },
  }
end

return M
