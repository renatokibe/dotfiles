local M = {}

M.setup = function()
  local dap = require("dap")

  -- Python debugpy adapter is configured by mason-nvim-dap
  -- We just need to add configurations

  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      pythonPath = function()
        -- Try to detect virtual environment
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          return cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        else
          return "/usr/bin/python3"
        end
      end,
    },
    {
      type = "python",
      request = "launch",
      name = "Launch file with arguments",
      program = "${file}",
      args = function()
        local args_string = vim.fn.input("Arguments: ")
        return vim.split(args_string, " ")
      end,
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          return cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        else
          return "/usr/bin/python3"
        end
      end,
    },
    {
      type = "python",
      request = "launch",
      name = "Django",
      program = "${workspaceFolder}/manage.py",
      args = {
        "runserver",
      },
      django = true,
      console = "integratedTerminal",
    },
    {
      type = "python",
      request = "launch",
      name = "Flask",
      module = "flask",
      env = {
        FLASK_APP = "app.py",
      },
      args = {
        "run",
      },
      jinja = true,
      console = "integratedTerminal",
    },
    {
      type = "python",
      request = "launch",
      name = "Python: Module",
      module = function()
        return vim.fn.input("Module name: ")
      end,
      console = "integratedTerminal",
    },
  }
end

return M
