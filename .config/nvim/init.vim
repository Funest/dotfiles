" TODO:MODIFIED hangs after save?
" Funest's Neovim config
set nocompatible
" Make it so TABs don't suck
set copyindent
set tabstop=4
set shiftwidth=4
set expandtab

" Written in blood:
set noautoread

" Compilation shortcut
nnoremap <F5> :w :make!

" Set the title of the terminal
set title

" Clear highlights with C-L
nnoremap  :noh

" Line numbers and highlight current line
set nu cul rnu
hi CursorLine ctermbg=Black cterm=none 
hi CursorLineNr cterm=none ctermbg=DarkGrey

" TODO: cusomize status line

" " vim-plug stuff
" call plug#begin('~/.vim/plugged')
" 
" Plug 'airblade/vim-gitgutter' " TODO: make work
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'Yggdroot/indentLine'
" Plug 'tpope/vim-commentary'
" 
" call plug#end()
" 
" Call my custom statusline
lua require('bar').setup()


""""" Latex stuff:
" No conceal - fight WYSIWYG
let g:tex_conceal=''
" Always use tex as default filetype
let g:tex_flavor='latex'

" Consider, if the configuration gets dense: redo structure - use init.lua, use an utils.lua, maps.lua, etc
" Consider: scratch buffer?

