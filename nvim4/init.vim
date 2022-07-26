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
Plug 'morhetz/gruvbox' " gruvbox colorshceme
Plug 'ryanoasis/vim-devicons' " Developer Icons

call plug#end()

" --------------------------------------------------------------------------------------- Key Bindings

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>

" --------------------------------------------------------------------------------------- Color Schemes

autocmd vimenter * ++nested colorscheme gruvbox
set background=dark

" add support for true-colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" --------------------------------------------------------------------------------------- Status Bar

" Activate gruvbox airline theme
let g:airline_theme='gruvbox'

" disable trailing section
let g:airline#extensions#whitespace#enabled = 0

" customize z section
let g:airline_section_z = "%p%% %l/%L : %c"
