# Claude Code Notes

## Dotfiles Management

This repository uses `rcup` to manage dotfiles symlinks.

### When to run rcup:

**ONLY run `rcup` when:**
- Adding new files to the dotfiles repo
- Renaming files
- Moving files to different locations
- Deleting files

**DO NOT run `rcup` when:**
- Editing existing files (changes are automatically reflected via symlinks)
- Modifying file contents

```bash
rcup -d ~/Projects/me/dotfiles
```

This will sync the dotfiles from this repo to their proper locations in your home directory by creating/updating symlinks.

### How rcup works:

`rcup` creates symlinks from `~/.config/`, `~/`, etc. to the files in this dotfiles repo. Because they're symlinks, any edits to files in the dotfiles repo are immediately reflected in the actual config locations. You only need to run `rcup` again if you're changing the structure (adding/removing/moving files), not when editing file contents.

### Common rcup commands:

- `rcup -d ~/Projects/me/dotfiles` - Update all symlinks
- `lsrc -d ~/Projects/me/dotfiles` - List what would be linked (dry run)
- `rcdn -d ~/Projects/me/dotfiles` - Remove all symlinks

## Neovim Configuration

### Structure

The neovim config has been migrated to pure Lua with lazy.nvim plugin manager:

```
config/nvim/
├── init.lua                    # Entry point with lazy.nvim bootstrap
├── lua/
│   ├── core/                   # Core vim settings
│   │   ├── options.lua         # All vim options
│   │   ├── keymaps.lua         # Key mappings
│   │   └── autocmds.lua        # Autocommands
│   ├── colorscheme/
│   │   └── init.lua            # Colorscheme configuration
│   ├── lang/                   # Language-specific configs
│   └── plugins/
│       ├── init.lua            # Plugin specifications for lazy.nvim
│       └── config/             # Individual plugin configs (NOT auto-loaded)
│           ├── cmp.lua
│           ├── treesitter.lua
│           └── ...
```

**Note:** Plugin config files are in `plugins/config/` subdirectory to prevent lazy.nvim from auto-loading them as plugin specs.

### Plugin Config Pattern

All plugin configs follow this framework-agnostic pattern:

```lua
local M = {}

M.setup = function()
  -- Plugin configuration code
end

return M
```

This allows configs to be called directly: `require("plugins.config.cmp").setup`

### Adding New Plugins

1. Add plugin spec to `plugins/init.lua`:
   ```lua
   { "author/plugin-name", config = require("plugins.config.pluginname").setup }
   ```

2. Create `plugins/config/pluginname.lua` with M.setup() pattern

3. Run `rcup -d ~/Projects/me/dotfiles` to sync

4. Launch nvim - lazy.nvim will install the plugin

### Known Deprecation Warnings

The following deprecation warnings are present but non-breaking. They should be addressed when the respective plugins release their breaking versions:

1. **CodeCompanion.nvim** (will break in v18.0.0):
   - Warning: `adapters.<adapter_name>` and `adapters.opts` is deprecated
   - Action needed: Migrate to `adapters.http.<adapter_name>` and `adapters.http.opts`
   - Files affected: `config/nvim/lua/plugins/config/codecompanion.lua`
   - Note: Current config doesn't use `adapters.opts`, so minimal changes needed

2. **nvim-lspconfig** (will break in v3.0.0, requires Neovim 0.11+):
   - Warning: The `require('lspconfig')` "framework" is deprecated
   - Action needed: Migrate to `vim.lsp.config` API (see `:help lspconfig-nvim-0.11`)
   - Files affected:
     - `config/nvim/lua/lang/config.lua`
     - `config/nvim/lua/lang/serenata.lua`
   - Note: This requires Neovim 0.11+ and will be a larger refactor
