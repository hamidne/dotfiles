" --------------------------------------------------------------------------------------- Configs

:set number
:set relativenumber 
:set autoindent
:set tabstop=4
:set softtabstop=4
:set shiftwidth=4
:set smarttab

" --------------------------------------------------------------------------------------- Plugins

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'   " Surrounding ( ysw} )
Plug 'tpope/vim-commentary' " For comment ( gcc & gc ) 

Plug 'preservim/nerdtree' " Explorer
Plug 'preservim/tagbar' " Tagbar for code navigation

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'rafi/awesome-vim-colorschemes'

Plug 'neoclide/coc.nvim' " Auto completions

Plug 'ryanoasis/vim-devicons' " Developer Icons


" Plug 'tpope/vim-fugitive'
" Plug 'scrooloose/syntastic'
" Plug 'kien/ctrlp.vim'
" Plug 'airblade/vim-gitgutter'
" Plug 'plasticboy/vim-markdown'
" Plug 'godlygeek/tabular'
" Plug 'arcticicestudio/nord-vim'
" 
call plug#end()

" --------------------------------------------------------------------------------------- Theme Settings

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews

let g:airline_powerline_fonts = 1

" Set colorsceme to nord
" silent! colorscheme nord

" Activate nord airline theme
" let g:airline_theme='nord'

