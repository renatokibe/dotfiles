-- Keymaps
-- Migrated from vimrc

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Clear highlight after search
keymap("n", "<Leader><space>", ":nohls<CR>", opts)

-- Window navigation (handled by vim-tmux-navigator plugin)
-- Disabled to avoid conflicts
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Force navigation through hjkl
keymap("n", "<Left>", ':echoe "Use h"<CR>', opts)
keymap("n", "<Right>", ':echoe "Use l"<CR>', opts)
keymap("n", "<Up>", ':echoe "Use k"<CR>', opts)
keymap("n", "<Down>", ':echoe "Use j"<CR>', opts)

-- Yank from current cursor position to end of line
keymap("n", "Y", "y$", opts)

-- Yank to system clipboard
keymap("n", "<Leader>y", '"+y', opts)
keymap("v", "<Leader>y", '"+y', opts)
keymap("n", "<Leader>p", '"+p', opts)

-- Yank current file relative path to system clipboard
keymap("n", "<Leader>yf", function()
  local path = vim.fn.expand('%:.')
  vim.fn.setreg('+', path)
  print('Yanked: ' .. path)
end, { noremap = true, silent = false, desc = "Yank relative file path" })

-- Tab navigation
keymap("n", "<Leader>tp", ":tabprevious<CR>", opts)
keymap("n", "<Leader>tn", ":tabnext<CR>", opts)

-- Buffer navigation
keymap("n", "<Leader>bp", ":bprevious<CR>", opts)
keymap("n", "<Leader>bn", ":bnext<CR>", opts)
keymap("n", "gb", ":e #<CR>", opts)

-- Splits (h = horizontal arrangement/side by side, v = vertical arrangement/top-bottom)
keymap("n", "<Leader>sh", "<C-w>v<C-w>l", opts)  -- horizontal arrangement (side by side)
keymap("n", "<Leader>sv", "<C-w>s<C-w>j", opts)  -- vertical arrangement (top and bottom)

-- Quickly edit config files
keymap("n", "<Leader>ev", "<C-w>s<C-w>j:e $MYVIMRC<CR>", opts)
keymap("n", "<Leader>eg", "<C-w>s<C-w>j:e ~/.gitconfig<CR>", opts)
keymap("n", "<Leader>ep", "<C-w>s<C-w>j:e ~/.profile<CR>", opts)
keymap("n", "<Leader>et", "<C-w>s<C-w>j:e ~/.tmux.conf<CR>", opts)

-- Reselect visual block after indent/outdent
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Keep search matches in the middle of the window
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Same when jumping around
keymap("n", "g;", "g;zz", opts)
keymap("n", "g,", "g,zz", opts)

-- Open a Quickfix window for the last search
keymap("n", "<Leader>?", ':execute "vimgrep /"..@/.."/g %"<CR>:copen<CR>', { silent = true })

-- Folding remaps
keymap("n", "zm", "zz", opts)  -- map default zz to zm
keymap("v", "zm", "zz", opts)
keymap("n", "zz", "za", opts)  -- toggle folds
keymap("v", "zz", "za", opts)
keymap("n", "zZ", "zA", opts)  -- toggle folds recursively
keymap("v", "zZ", "zA", opts)
keymap("n", "za", "zR", opts)  -- open all folds
keymap("v", "za", "zR", opts)
keymap("n", "zA", "zM", opts)  -- close all folds
keymap("v", "zA", "zM", opts)
keymap("n", "zO", "zCzO", opts)  -- recursively open top level fold

-- Fast saving
keymap("n", "<Leader>w", ":w!<CR>", opts)
keymap("n", "<Leader>wq", ":wq!<CR>", opts)

-- Toggle number gutter
keymap("n", "<Leader>m", ":set invnumber<CR>", opts)
keymap("i", "<Leader>m", "<C-O>:set invnumber<CR>", opts)

-- Redraw panels
keymap("n", "<Leader>=", "<C-w>=", opts)

-- Open current file with default app
keymap("n", "<Leader>o", ":!open %<CR>", { silent = true })

-- FZF-lua file finding and grep
keymap("n", "<C-t>", "<cmd>lua require('fzf-lua').files()<CR>", { desc = "Find files" })
keymap("n", "<Leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { desc = "Find files" })
keymap("n", "<Leader>fg", "<cmd>lua require('fzf-lua').git_files()<CR>", { desc = "Git files" })
keymap("n", "<Leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { desc = "Buffers" })
keymap("n", "<Leader>fh", "<cmd>lua require('fzf-lua').help_tags()<CR>", { desc = "Help tags" })
keymap("n", "<Leader>fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { desc = "Recent files" })
keymap("n", "<Leader>fl", "<cmd>lua require('fzf-lua').blines()<CR>", { desc = "Lines in buffer" })
keymap("n", "<Leader>fL", "<cmd>lua require('fzf-lua').lines()<CR>", { desc = "Lines in open buffers" })
keymap("n", "<Leader>ft", "<cmd>lua require('fzf-lua').btags()<CR>", { desc = "Buffer tags" })
keymap("n", "<Leader>fT", "<cmd>lua require('fzf-lua').tags()<CR>", { desc = "Project tags" })

-- Grep with fzf-lua
keymap("n", "<Leader>a", "<cmd>lua require('fzf-lua').grep()<CR>", { desc = "Grep (two-phase: prompt then fuzzy)" })
keymap("n", "<Leader>A", "<cmd>lua require('fzf-lua').grep_project()<CR>", { desc = "Grep project (resume last search)" })
keymap("n", "<Leader>fG", "<cmd>lua require('fzf-lua').live_grep()<CR>", { desc = "Live grep (interactive)" })

-- Search word under cursor with fzf-lua
keymap("n", "<Leader>aw", "<cmd>lua require('fzf-lua').grep_cword()<CR>", { desc = "Grep word under cursor" })
keymap("v", "<Leader>aw", "<cmd>lua require('fzf-lua').grep_visual()<CR>", { desc = "Grep visual selection" })
keymap("n", "<Leader>acf", "<cmd>lua require('fzf-lua').grep_project({search=vim.fn.expand('%:t:r')})<CR>", { desc = "Grep current filename" })

-- Vim eunuch
keymap("n", "<Leader>mv", ":Rename ", { noremap = true })

-- Better whitespace
keymap("n", "<Leader>rw", ":StripWhitespace<CR>", opts)
keymap("n", "<Leader>tw", ":ToggleWhitespace<CR>", opts)

-- Startify
keymap("n", "<Leader>st", ":Startify<CR>", opts)

-- Goyo
keymap("n", "<Leader>f", ":Goyo<CR>", opts)

-- Localorie (Rails i18n)
keymap("n", "<Leader>lt", ":lua require('localorie').translate()<CR>", opts)
keymap("n", "<Leader>le", ":lua require('localorie').expand_key()<CR>", opts)

-- Lazy.nvim plugin manager
keymap("n", "<Leader>pi", ":Lazy install<CR>", opts)
keymap("n", "<Leader>pu", ":Lazy update<CR>", opts)
keymap("n", "<Leader>ps", ":Lazy sync<CR>", opts)

-- Fugitive
keymap("n", "<Leader>gst", ":Gstatus<CR>", opts)
keymap("n", "<Leader>gci", ":Gcommit<CR>", opts)
keymap("n", "<Leader>gmv", ":Gmove<CR>", opts)
keymap("n", "<Leader>gb", ":GBrowse<CR>", opts)
keymap("n", "<Leader>gbl", ":. Gbrowse<CR>", opts)
keymap("n", "<Leader>gam", ":Git amend<CR>", opts)
keymap("n", "<Leader>gblm", ":Gblame<CR>", opts)

-- Git search for word under cursor
keymap("n", "<Leader>gf", ':let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>', { noremap = true })
keymap("v", "<Leader>gf", 'y:let @/=escape(@", "\\\\[]$^*.")<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", "\\\\\\"#")<CR>"<CR>:ccl<CR>:cw<CR><CR>', { noremap = true })

-- Gist creation from visual selection
keymap("n", "<Leader>G", ":w !gist -p -t %:e \\| pbcopy<CR>", { noremap = true })

-- Suda (sudo write)
keymap("n", "<Leader>ws", ":SudaWrite<CR>", opts)

-- Terminal mode alt key navigation
if vim.fn.has("nvim") == 1 then
  keymap("t", "<a-a>", "<esc>a", opts)
  keymap("t", "<a-b>", "<esc>b", opts)
  keymap("t", "<a-d>", "<esc>d", opts)
  keymap("t", "<a-f>", "<esc>f", opts)
end

-- LSP via fzf-lua
keymap("n", "<Leader>cs", "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", { desc = "Document symbols" })
keymap("n", "<Leader>cS", "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>", { desc = "Workspace symbols" })
keymap("n", "<Leader>ca", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", { desc = "Code actions" })
keymap("n", "<Leader>cr", "<cmd>lua require('fzf-lua').lsp_references()<CR>", { desc = "References" })
keymap("n", "<Leader>cd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", { desc = "Definitions" })
keymap("n", "<Leader>ci", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", { desc = "Implementations" })
keymap("n", "<Leader>ct", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", { desc = "Type definitions" })
keymap("n", "<Leader>cD", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<CR>", { desc = "Document diagnostics" })
keymap("n", "<Leader>cW", "<cmd>lua require('fzf-lua').lsp_workspace_diagnostics()<CR>", { desc = "Workspace diagnostics" })

-- Trouble.nvim - Diagnostics viewer
keymap("n", "<Leader>xx", ":Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics (Trouble)" })
keymap("n", "<Leader>xX", ":Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics (Trouble)" })
keymap("n", "<Leader>xl", ":Trouble loclist toggle<CR>", { desc = "Location list (Trouble)" })
keymap("n", "<Leader>xq", ":Trouble qflist toggle<CR>", { desc = "Quickfix list (Trouble)" })
keymap("n", "<Leader>xs", ":Trouble symbols toggle focus=false<CR>", { desc = "Symbols (Trouble)" })
keymap("n", "<Leader>xL", ":Trouble lsp toggle focus=false win.position=right<CR>", { desc = "LSP references/definitions (Trouble)" })

-- DAP (Debug Adapter Protocol) keymaps
keymap("n", "<Leader>db", ":DapToggleBreakpoint<CR>", vim.tbl_extend("force", opts, { desc = "Toggle breakpoint" }))
keymap("n", "<Leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, vim.tbl_extend("force", opts, { desc = "Conditional breakpoint" }))
keymap("n", "<Leader>dc", ":DapContinue<CR>", vim.tbl_extend("force", opts, { desc = "Continue" }))
keymap("n", "<Leader>dC", function()
  require("dap").run_to_cursor()
end, vim.tbl_extend("force", opts, { desc = "Run to cursor" }))
keymap("n", "<Leader>di", ":DapStepInto<CR>", vim.tbl_extend("force", opts, { desc = "Step into" }))
keymap("n", "<Leader>do", ":DapStepOver<CR>", vim.tbl_extend("force", opts, { desc = "Step over" }))
keymap("n", "<Leader>dO", ":DapStepOut<CR>", vim.tbl_extend("force", opts, { desc = "Step out" }))
keymap("n", "<Leader>dr", function()
  require("dapui").toggle()
end, vim.tbl_extend("force", opts, { desc = "Toggle DAP UI" }))
keymap("n", "<Leader>dt", ":DapTerminate<CR>", vim.tbl_extend("force", opts, { desc = "Terminate" }))
keymap("n", "<Leader>dh", function()
  require("dap.ui.widgets").hover()
end, vim.tbl_extend("force", opts, { desc = "Hover" }))
keymap("n", "<Leader>dp", function()
  require("dap.ui.widgets").preview()
end, vim.tbl_extend("force", opts, { desc = "Preview" }))
keymap("n", "<Leader>dR", function()
  require("dap").repl.open()
end, vim.tbl_extend("force", opts, { desc = "Open REPL" }))
