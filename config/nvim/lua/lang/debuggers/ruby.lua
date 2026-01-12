local M = {}

M.setup = function()
  local dap = require("dap")

  -- Ruby rdbg adapter (built into Ruby 3.1+)
  dap.adapters.ruby = function(callback, config)
    callback({
      type = "server",
      host = "127.0.0.1",
      port = "${port}",
      executable = {
        command = "bundle",
        args = {
          "exec",
          "rdbg",
          "-n",
          "--open",
          "--port",
          "${port}",
          "-c",
          "--",
          config.command,
          unpack(config.args or {}),
        },
      },
    })
  end

  -- Ruby configurations
  dap.configurations.ruby = {
    {
      type = "ruby",
      request = "launch",
      name = "Debug current Ruby file",
      program = "${file}",
      args = {},
      command = "ruby",
    },
    {
      type = "ruby",
      request = "launch",
      name = "Debug current Ruby file (with args)",
      program = "${file}",
      args = function()
        local args_string = vim.fn.input("Arguments: ")
        return vim.split(args_string, " ")
      end,
      command = "ruby",
    },
    {
      type = "ruby",
      request = "launch",
      name = "Debug Rails server",
      program = "bin/rails",
      args = { "server" },
      command = "ruby",
    },
    {
      type = "ruby",
      request = "launch",
      name = "Debug RSpec (current file)",
      program = "${file}",
      args = {},
      command = "rspec",
    },
  }
end

return M
