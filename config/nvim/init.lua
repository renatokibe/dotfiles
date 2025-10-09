-- ============================================================================
-- Neovim Configuration
-- Entry point for neovim config
-- ============================================================================

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration (must be before plugins)
require("core.options")   -- Options and settings
require("core.keymaps")   -- Key mappings
require("core.autocmds")  -- Autocommands

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Import plugin specifications from lua/plugins/
    { import = "plugins" },
  },
  defaults = {
    lazy = false,  -- Don't lazy-load by default
    version = false,  -- Use latest git commit
  },
  install = {
    colorscheme = { "nordic", "habamax" },
  },
  checker = {
    enabled = false,  -- Don't automatically check for updates
  },
  change_detection = {
    enabled = true,
    notify = false,  -- Don't notify on config changes
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Load colorscheme after plugins are loaded
require("colorscheme")

-- Load language specific settings
require("lang")
