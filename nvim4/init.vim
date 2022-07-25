" --------------------------------------------------------------------------------------- Configuration

:set number
:set relativenumber 
:set autoindent
:set tabstop=4
:set softtabstop=4
:set shiftwidth=4
:set smarttab
:set completeopt-=preview " For No Previews

" --------------------------------------------------------------------------------------- Plugins

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'   " Surrounding ( ysw} )
Plug 'tpope/vim-commentary' " For comment ( gcc & gc ) 

Plug 'preservim/nerdtree' " Explorer
Plug 'preservim/tagbar' " Tagbar for code navigation

Plug 'vim-airline/vim-airline' " status bar
Plug 'vim-airline/vim-airline-themes' " status bar themes

Plug 'morhetz/gruvbox' " gruvbox colorshceme

Plug 'ryanoasis/vim-devicons' " Developer Icons

" Plug 'neoclide/coc.nvim' " Auto completions
" Plug 'tpope/vim-fugitive'
" Plug 'scrooloose/syntastic'
" Plug 'kien/ctrlp.vim'
" Plug 'airblade/vim-gitgutter'
" Plug 'plasticboy/vim-markdown'
" Plug 'godlygeek/tabular'

call plug#end()

" --------------------------------------------------------------------------------------- Key Bindings

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>

" --------------------------------------------------------------------------------------- Color Schemes

" Set colorsceme to gruvbox
autocmd vimenter * ++nested colorscheme gruvbox

" --------------------------------------------------------------------------------------- Status Bar

" Activate gruvbox airline theme
let g:airline_theme='gruvbox'

" set airline font
let g:airline_powerline_fonts = 1

" don't show error if we have disabled some sections
let g:airline_skip_empty_sections = 1

" disable trailing section
let g:airline#extensions#whitespace#enabled = 0

" customize z section
let g:airline_section_z = "%p%% %l/%L : %c"

