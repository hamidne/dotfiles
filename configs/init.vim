" in the name of God

" --------------------------------------------------------------------------------------- Configs

:set number
:set relativenumber 
:set autoindent
:set tabstop=4
:set softtabstop=4
:set shiftwidth=4
:set smarttab
:set mouse=a

" --------------------------------------------------------------------------------------- Plugins

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround' " Surrounding ( ysw} )
Plug 'preservim/nerdtree' " NerdTree (  )
Plug 'tpope/vim-commentary' " For comment ( gcc & gc ) 

" Plug 'tpope/vim-fugitive'
" Plug 'scrooloose/syntastic'
" Plug 'kien/ctrlp.vim'
" Plug 'airblade/vim-gitgutter'
" Plug 'plasticboy/vim-markdown'
" Plug 'godlygeek/tabular'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'arcticicestudio/nord-vim'
" 
call plug#end()

" --------------------------------------------------------------------------------------- Theme Settings

" Set colorsceme to nord
silent! colorscheme nord

" Activate nord airline theme
let g:airline_theme='nord'
