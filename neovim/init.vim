syntax on
filetype plugin indent on

" spaces instead of tabs
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

set encoding=utf-8
set number

" Plugins
call plug#begin('~/.vim/plugged')

" General
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'Raimondi/delimitMate'
Plug 'altercation/vim-colors-solarized'
Plug 'ervandew/supertab'

call plug#end()

" Neomake
autocmd! BufWritePost * Neomake

" Deoplete
let g:deoplete#enable_at_startup=1