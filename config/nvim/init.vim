set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require('colorscheme')
lua require('plugins')
lua require('lang')
