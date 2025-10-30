-- Autocommands
-- Migrated from vimrc

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Only show cursorline in the current window and in normal mode
local cursorline_group = augroup("CursorLine", { clear = true })
autocmd("WinLeave", {
  group = cursorline_group,
  pattern = "*",
  command = "set nocursorline"
})
autocmd("WinEnter", {
  group = cursorline_group,
  pattern = "*",
  command = "set cursorline"
})
autocmd("InsertEnter", {
  group = cursorline_group,
  pattern = "*",
  command = "set nocursorline"
})
autocmd("InsertLeave", {
  group = cursorline_group,
  pattern = "*",
  command = "set cursorline"
})

-- Auto change directory to project root using LSP
-- Replaces vim-rooter plugin with native Neovim functionality
local lsp_rooter_group = augroup("LspRooter", { clear = true })
autocmd("LspAttach", {
  group = lsp_rooter_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.config.root_dir then
      vim.fn.chdir(client.config.root_dir)
    end
  end,
})

-- Always reload vimrc after save
local reload_vimrc_group = augroup("ReloadVimrc", { clear = true })
autocmd("BufWritePost", {
  group = reload_vimrc_group,
  pattern = { "**/dotfiles/vimrc", "**/.config/nvim/init.lua", "**/.config/nvim/lua/**/*.lua" },
  command = "source <afile>"
})

-- Goyo integration with tmux
local goyo_group = augroup("GoyoSettings", { clear = true })
autocmd("User", {
  group = goyo_group,
  pattern = "GoyoEnter",
  callback = function()
    vim.cmd("silent !tmux set status off")
    vim.cmd("silent !tmux list-panes -F '\\#F' | grep -q Z || tmux resize-pane -Z")
    vim.opt.showmode = false
    vim.opt.showcmd = false
    vim.opt.scrolloff = 999
  end
})
autocmd("User", {
  group = goyo_group,
  pattern = "GoyoLeave",
  callback = function()
    vim.cmd("silent !tmux set status on")
    vim.cmd("silent !tmux list-panes -F '\\#F' | grep -q Z && tmux resize-pane -Z")
    vim.opt.showmode = true
    vim.opt.showcmd = true
    vim.opt.scrolloff = 5
  end
})

-- Vim config file configuration
local vim_config_group = augroup("VimConfig", { clear = true })
autocmd("FileType", {
  group = vim_config_group,
  pattern = "vim",
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end
})
autocmd("FileType", {
  group = vim_config_group,
  pattern = "help",
  callback = function()
    vim.opt_local.textwidth = 100
  end
})
autocmd("BufWinEnter", {
  group = vim_config_group,
  pattern = "*.txt",
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd("wincmd L")
    end
  end
})

-- Ruby and Ruby on Rails
local ruby_group = augroup("RubySettings", { clear = true })
autocmd("FileType", {
  group = ruby_group,
  pattern = { "ruby", "eruby", "yaml", "less" },
  callback = function()
    vim.opt_local.textwidth = 100
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
  end
})
autocmd("FileType", {
  group = ruby_group,
  pattern = "ruby",
  command = "setlocal indentkeys-=."
})
autocmd("User", {
  group = ruby_group,
  pattern = "Rails",
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = true
  end
})

-- Lua
local lua_group = augroup("LuaSettings", { clear = true })
autocmd("FileType", {
  group = lua_group,
  pattern = "lua",
  callback = function()
    vim.opt_local.textwidth = 100
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
  end
})

-- JavaScript, TypeScript, React
local js_group = augroup("JavaScriptSettings", { clear = true })
autocmd("FileType", {
  group = js_group,
  pattern = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
  callback = function()
    vim.opt_local.textwidth = 100
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
  end
})

-- HTML and templates
local html_group = augroup("HTMLSettings", { clear = true })
autocmd({ "BufNewFile", "BufReadPost" }, {
  group = html_group,
  pattern = { "*.jade", "*.html", "*.slim" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end
})
autocmd({ "BufNewFile", "BufReadPost" }, {
  group = html_group,
  pattern = "*.tt",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.filetype = "tt2html"
  end
})

-- PHP
local php_group = augroup("PHPSettings", { clear = true })
autocmd({ "BufNewFile", "BufReadPost" }, {
  group = php_group,
  pattern = "*.php",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.textwidth = 80
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
  end
})

-- Python
local python_group = augroup("PythonSettings", { clear = true })
autocmd({ "BufNewFile", "BufReadPost" }, {
  group = python_group,
  pattern = "*.py",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.textwidth = 80
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
  end
})

-- Emmet for HTML/CSS
local emmet_group = augroup("EmmetSettings", { clear = true })
autocmd("FileType", {
  group = emmet_group,
  pattern = { "html", "eruby", "css", "tt", "tt2", "tt2html" },
  command = "EmmetInstall"
})

-- Redraw panels on focus lost and window resize
local redraw_group = augroup("RedrawOnFocusOut", { clear = true })
autocmd({ "FocusLost", "VimResized" }, {
  group = redraw_group,
  pattern = "*",
  command = "silent wincmd ="
})

-- Share data between neovim instances (registers etc) using shada
-- Only sync on focus loss to avoid excessive writes and temp file buildup
local shada_group = augroup("SHADA", { clear = true })
autocmd({ "FocusLost" }, {
  group = shada_group,
  pattern = "*",
  callback = function()
    if vim.fn.exists(":rshada") == 2 then
      pcall(function()
        vim.cmd("wshada")
      end)
    end
  end
})

-- Read shared data when gaining focus
autocmd({ "FocusGained" }, {
  group = shada_group,
  pattern = "*",
  callback = function()
    if vim.fn.exists(":rshada") == 2 then
      pcall(function()
        vim.cmd("rshada")
      end)
    end
  end
})

-- Highlight VCS conflict markers
vim.fn.matchadd("ErrorMsg", [[^\(<\|=\|>\)\{7\}\([^=].\+\)\?$]])
