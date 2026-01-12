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
rcup
```

This will sync the dotfiles from this repo to their proper locations in your home directory by creating/updating symlinks. The dotfiles directory is configured in `rcrc` via the `DOTFILES_DIR` environment variable (defaults to `$HOME/Projects/me/dotfiles`).

### How rcup works:

`rcup` creates symlinks from `~/.config/`, `~/`, etc. to the files in this dotfiles repo. Because they're symlinks, any edits to files in the dotfiles repo are immediately reflected in the actual config locations. You only need to run `rcup` again if you're changing the structure (adding/removing/moving files), not when editing file contents.

### Common rcup commands:

- `rcup` - Update all symlinks (uses `DOTFILES_DIR` from `rcrc`)
- `lsrc` - List what would be linked (dry run)
- `rcdn` - Remove all symlinks

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

3. Run `rcup` to sync

4. Launch nvim - lazy.nvim will install the plugin

### Plugin Management

The config uses lazy.nvim as the plugin manager (migrated from vim-plug).

**Commands:**
- `:Lazy` - Open lazy.nvim UI
- `:Lazy install` - Install missing plugins
- `:Lazy update` - Update plugins
- `:Lazy sync` - Install missing and update existing plugins
- `:Lazy clean` - Remove unused plugins

**Keymaps:**
- `<Leader>pi` - Install missing plugins
- `<Leader>pu` - Update plugins
- `<Leader>ps` - Sync plugins (install + update)

All plugins are defined in `plugins/init.lua` with their configurations in `plugins/config/` directory.

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

## Tmux Configuration

### Overview

This repository includes a comprehensive tmux configuration with:
- Nord color theme for consistent aesthetics
- Vim-style keybindings and navigation
- Session persistence (auto-saves every 15 minutes)
- Enhanced pane visibility with background highlighting
- Integration with system clipboard
- Mouse support with scroll wheel

**Configuration File:** `tmux.conf`
**Prefix Key:** `Ctrl-f` (instead of default `Ctrl-b`)

### Structure

```
├── tmux.conf           # Main configuration
├── tmux_osx.conf       # macOS-specific settings (sourced automatically)
└── tmux_linux.conf     # Linux-specific settings (sourced automatically)
```

### Plugin Manager

Uses TPM (Tmux Plugin Manager) for plugin installation and management.

**Key Plugins:**
- `arcticicestudio/nord-tmux` - Nord color theme
- `christoomey/vim-tmux-navigator` - Seamless vim/tmux navigation
- `tmux-plugins/tmux-yank` - System clipboard integration
- `tmux-plugins/tmux-resurrect` - Save/restore sessions
- `tmux-plugins/tmux-continuum` - Automatic session saving (every 15 min)
- `tmux-plugins/tmux-prefix-highlight` - Visual prefix key indicator
- `sainnhe/tmux-fzf` - FZF integration for tmux
- `AngryMorrocoy/tmux-neolazygit` - Lazygit integration (Prefix + g)

**Plugin Commands:**
- `Prefix + I` - Install new plugins
- `Prefix + U` - Update plugins
- `Prefix + Alt + u` - Uninstall removed plugins

### Key Bindings

#### Window Management
- `Prefix + c` - New window (in current directory)
- `Alt + 1-9` - Switch to window 1-9
- `Prefix + Ctrl-p` - Previous window
- `Prefix + Ctrl-n` - Next window

#### Pane Management
- `Prefix + h` - Split horizontal (side-by-side panes)
- `Prefix + v` - Split vertical (top/bottom panes)
- `Prefix + Left/Right/Up/Down` - Resize pane
- `Prefix + q` - Show pane numbers (displays immediately)
- `Ctrl-h/j/k/l` - Navigate between panes (vim-tmux-navigator)

#### Session Management
- `Prefix + S` - Toggle pane synchronization
- `Prefix + Ctrl-g` - Open popup terminal (80% size)
- `Prefix + g` - Open lazygit in current pane
- `Prefix + r` - Reload tmux config

#### Copy Mode (Vim-style)
- `Prefix + [` - Enter copy mode
- `v` - Begin selection
- `Ctrl-v` - Rectangle selection
- `y` - Yank (copy) and exit
- Mouse drag also works for selection

### Visual Pane Identification

The active pane is identified through multiple visual cues:

1. **Pane Border Status Line**
   - Active pane: Blue status line at the top with pane number (e.g., "0:0")
   - Inactive panes: Gray status line at the top
   - Appears on ALL panes regardless of position
   - Shows window index and pane index (#I:#P)

2. **Background Highlighting** (Nord-themed)
   - Active pane: Default terminal background (unchanged from original)
   - Inactive panes: Very subtly dimmed background (`colour234`)
   - Configured via `window-active-style` and `window-style`
   - Provides clear visual distinction independent of cursor position

3. **Border Colors** (Nord Theme)
   - Active border: Blue (`blue`)
   - Inactive border: Bright black / dark gray (`brightblack`)
   - Set by Nord theme plugin
   - Note: Borders only appear between adjacent panes

4. **Pane Numbers** (Quick Reference)
   - Press `Prefix + q` to show large pane numbers overlay
   - Numbers display immediately (no delay, `-d 0` option)

**Nord Color Reference:**
- Default: Active pane background (your terminal's default)
- colour234: Inactive pane background (minimal dimming, brighter than colour235)
- Nord3 (#4C566A / brightblack): Border and inactive status line color
- Nord8 (#88C0D0 / blue): Active pane border and status line color

### Terminal Settings

- **Terminal type:** `tmux-256color` with true color support
- **Color support:** 256 colors + true color (Tc) override
- **Special features:**
  - Undercurl support for LSP diagnostics
  - Focus events enabled (improves vim integration)
  - Status bar refresh: 5 seconds
  - Escape time: 10ms (fast vim mode switching)

### Session Persistence

Sessions are automatically saved every 15 minutes and restored on tmux server start.

- **Manual save:** `Prefix + Ctrl-s`
- **Manual restore:** `Prefix + Ctrl-r`
- **Save location:** `~/.tmux/resurrect/`

### Troubleshooting

**Active pane not clearly visible:**
- Ensure `window-active-style` is set AFTER Nord theme loads in `tmux.conf`
- Check terminal supports 256 colors: `echo $TERM` should show `tmux-256color`
- Reload config: `Prefix + r`

**Vim navigation not working:**
- Ensure `vim-tmux-navigator` plugin is installed
- In vim, ensure you have the corresponding vim plugin installed

**Colors look wrong:**
- Check `terminal-overrides` settings in `tmux.conf`
- Verify your terminal emulator supports true color
- Try: `tmux kill-server` then restart tmux

**Status bar not updating:**
- Check if TPM plugins are installed: `ls ~/.tmux/plugins/`
- Install plugins with `Prefix + I`
- Reload config: `Prefix + r`
