filetype plugin off
syntax on
filetype plugin indent on
set mouse=a
nnoremap <C-j> <C-W><C-J>
nnoremap <C-h> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-k> <C-W><C-H>
let mapleader = "`"
" resize current buffer by +/- 5 
nnoremap <C-Down>  :vertical resize -1<cr>
nnoremap <C-Up>    :resize +1<cr>
nnoremap <C-Right> :resize -1<cr>
nnoremap <C-Left>  :vertical resize +1<cr>
nnoremap <NL> i<CR><ESC>
inoremap <C-a> <C-x><C-u>
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set clipboard=unnamedplus
"set conceallevel=2
"set concealcursor=vin
"set completeopt-=preview
if &diff
	colorscheme evening
endif
let python_highlight_all=1
syntax on
