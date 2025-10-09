-- Neovim Options
-- Migrated from vimrc

local opt = vim.opt
local g = vim.g

-- Leader keys
g.mapleader = ","
g.maplocalleader = "\\"

-- General settings
opt.encoding = "utf-8"
opt.history = 1000
opt.wildmenu = true
opt.wildignore = {
  ".svn", "CVS", ".git", ".hg", "*.o", "*.a", "*.class", "*.mo", "*.la",
  "*.so", "*.obj", "*.swp", "*.jpg", "*.png", "*.xpm", "*.gif", ".DS_Store",
  "*.aux", "*.out", "*.toc", "tmp", "*.scssc"
}

-- Display settings
opt.ruler = true
opt.showcmd = true
opt.laststatus = 2
opt.cmdheight = 2
opt.updatetime = 300
opt.shortmess:append("c")
opt.lazyredraw = true

-- Line numbers
opt.number = true
opt.numberwidth = 4
opt.signcolumn = "number"

-- Search
opt.hlsearch = true
opt.incsearch = true

-- Indentation
opt.autoindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.formatoptions:append("j")

-- Text width and wrapping
opt.textwidth = 80
opt.colorcolumn = "+1"

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Backspace
opt.backspace = { "indent", "eol", "start" }

-- Files and backups
opt.hidden = true
opt.autowrite = true
opt.autoread = true
opt.fileformats:append("mac")
opt.confirm = true

-- Backup and swap
local dotvim = vim.fn.expand("~/.vim/")
opt.backupdir = dotvim .. "tmp/backup//"
opt.directory = dotvim .. "tmp/swap//"
opt.backup = true
opt.swapfile = false

-- Undo
opt.undodir = dotvim .. "tmp/undo//"
opt.undofile = true
opt.undolevels = 3000
opt.undoreload = 10000

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 0
opt.foldenable = false

-- Visual
opt.list = true
opt.listchars = { tab = "▸ ", eol = "¬", extends = "❯", precedes = "❮" }
opt.showbreak = "↪"
opt.cursorline = true

-- Diff
opt.diffopt:append("vertical")

-- Colors
opt.termguicolors = true
opt.background = "dark"

-- Mouse
opt.mouse = ""  -- Disable mouse

-- GUI cursor
opt.guicursor:append("n-v-c:blinkon0")

-- Per project vimrc
opt.exrc = true
opt.secure = true
