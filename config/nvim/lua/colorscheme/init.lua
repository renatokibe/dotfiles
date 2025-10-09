-- vim.opt.background="light"
-- vim.cmd('colorscheme everforest')
-- vim.g.everforest_cursor = 'red'
-- vim.cmd("let g:everforest_cursor = 'red'")
-- vim.opt.colorscheme='everforest'


vim.g.nord_underline_option = 'none'
vim.g.nord_italic = 'v:true'
vim.g.nord_italic_comments = 'v:false'
vim.g.nord_minimal_mode = 'v:false'
vim.opt.background="dark"

-- Try to load colorscheme, fallback to default if not installed yet
local status_ok, _ = pcall(vim.cmd, 'colorscheme nordic')
if not status_ok then
  vim.cmd('colorscheme habamax')  -- Fallback to built-in colorscheme
end

-- colorscheme everforest

-- " let g:nord_italic = 1
-- " let g:nord_italic_comments = 1

-- " use treesitter (currently the fork is installed until it gets merged)
-- " let g:nord_enable_treesitter = 1
-- " silent! colorscheme nord

-- " gruvbox
-- "let g:gruvbox_contrast_dark = 'soft'
-- "let g:gruvbox_contrast_light = 'soft'
-- "silent! colorscheme gruvbox " set it silently cause the colorscheme may not exist yet

-- "set termguicolors     " enable true colors support
-- "let ayucolor="mirage" " for mirage version of theme
-- "silent! colorscheme ayu
-- " seoul256
-- "let g:seoul256_background = 239
-- "silent! colorscheme seoul256 " set it silently cause the colorscheme may not exist yet
