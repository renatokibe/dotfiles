# Neovim Keymaps Reference

This document lists custom keymaps added to the Neovim configuration. All keymaps use `,` as the leader key.

## Git Operations (gitsigns.nvim)

### Navigation
- `]c` - Next git hunk
- `[c` - Previous git hunk

### Hunk Actions
- `<Leader>hs` - Stage hunk (works in visual mode)
- `<Leader>hr` - Reset hunk (works in visual mode)
- `<Leader>hS` - Stage entire buffer
- `<Leader>hR` - Reset entire buffer
- `<Leader>hu` - Undo stage hunk
- `<Leader>hp` - Preview hunk inline

### Blame
- `<Leader>hb` - Show full blame in popup
- `<Leader>tb` - Toggle inline blame on/off
- Inline blame automatically shows at end of line (500ms delay)

### Diff
- `<Leader>hd` - Diff this file
- `<Leader>hD` - Diff against HEAD~
- `<Leader>td` - Toggle showing deleted lines

### Text Objects
- `ih` - Select hunk (works in visual/operator-pending mode)

## File Finding & Search (fzf-lua)

### File Navigation
- `<C-t>` - Find files (same as `<Leader>ff`)
- `<Leader>ff` - Find files
- `<Leader>fg` - Git files only
- `<Leader>fb` - List open buffers
- `<Leader>fh` - Search help tags
- `<Leader>fo` - Recent files (oldfiles)

### Buffer/Line Search
- `<Leader>fl` - Lines in current buffer
- `<Leader>fL` - Lines in all open buffers
- `<Leader>ft` - Buffer tags (current file)
- `<Leader>fT` - Project tags (all files)

### Grep/Search
- `<Leader>a` - Grep (two-phase: prompt once, then fuzzy filter results - like old Ag)
- `<Leader>A` - Grep project (resume last search)
- `<Leader>fG` - Live grep (interactive - updates as you type)
- `<Leader>aw` - Grep word under cursor (also works in visual mode)
- `<Leader>acf` - Grep current filename

## LSP Operations (fzf-lua)

### Symbols
- `<Leader>cs` - Document symbols (current file)
- `<Leader>cS` - Workspace symbols (whole project)

### Navigation
- `<Leader>cd` - Go to definitions
- `<Leader>cr` - Find references
- `<Leader>ci` - Find implementations
- `<Leader>ct` - Go to type definitions

### Actions
- `<Leader>ca` - Code actions

### Diagnostics
- `<Leader>cD` - Document diagnostics (current buffer)
- `<Leader>cW` - Workspace diagnostics (all files)

## Diagnostics Viewer (trouble.nvim)

### Main Views
- `<Leader>xx` - Toggle diagnostics (all workspace diagnostics)
- `<Leader>xX` - Buffer diagnostics (current buffer only)
- `<Leader>xs` - Symbols outline view
- `<Leader>xL` - LSP references/definitions (right panel)

### Lists
- `<Leader>xl` - Location list
- `<Leader>xq` - Quickfix list

## Tips

### FZF-lua Preview Controls
While in any fzf-lua picker:
- `<F1>` - Toggle help
- `<F2>` - Toggle fullscreen
- `<F3>` - Toggle preview wrap
- `<F4>` - Toggle preview
- `<C-d>` - Preview page down
- `<C-u>` - Preview page up
- `<C-q>` - Select all and accept

### Git Workflow Example
1. Make changes to code
2. `<Leader>hp` - Preview what changed
3. `<Leader>hs` - Stage the hunk
4. `<Leader>hb` - Check blame if needed
5. Use vim-fugitive for commit (`:Git commit`)

### LSP Workflow Example
1. `<Leader>cs` - See all symbols in file
2. `<Leader>ca` - See available code actions
3. `<Leader>cr` - Find all references to symbol
4. `<Leader>cd` - Jump to definition
5. `<Leader>xx` - See all diagnostics in project

### Search Workflow Example
1. `<C-t>` - Quick file search
2. `<Leader>fg` - Search only git-tracked files
3. `<Leader>aw` - Search for word under cursor
4. `<Leader>a` - Two-phase search (type pattern, press Enter, then fuzzy filter ALL results with hjkl)
5. `<Leader>fG` - Live grep (results update as you type - no fuzzy filtering)

**Two-Phase vs Live Grep:**
- **Two-phase** (`<Leader>a`): Type "function", press Enter → see ALL matches → fuzzy filter with "foo" → navigate with hjkl
- **Live grep** (`<Leader>fG`): Type "function foo" → only see matches for "function foo" → navigate with hjkl

## Other Keymaps

See `lua/core/keymaps.lua` for all other keymaps including:
- Window navigation (vim-tmux-navigator)
- Buffer/tab navigation
- Editing shortcuts
- Git commands (fugitive)
- And more...
