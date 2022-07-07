set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set relativenumber
set nu
set nohlsearch
set incsearch
set scrolloff=8
set colorcolumn=80

" plugin begin ===
call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'vim-airline/vim-airline'
Plug 'szw/vim-maximizer'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-syntastic/syntastic'

call plug#end()
" pluugin end ===

" setup first!
colorscheme gruvbox
set background=dark

" Vim Plugin Mappings
let mapleader = " "
vnoremap <leader>p :w ! python3<CR>

" ########################################################################
" ######## NERDTree
" ########################################################################
nnoremap <Leader>d :NERDTreeToggle<CR>
nnoremap <Leader>nt :NERDTree<CR>
nnoremap <Leader>nf :NERDTreeFind <CR>
let NERDTreeWinPos="left"
let NERDTreeWinSize=30
let NERDTreeShowHidden=1

" ########################################################################
" ######## Max
" ########################################################################
nnoremap <Leader>m :MaximizerToggle<CR>

" ########################################################################
" ######## YCM
" ########################################################################
map <Leader>q :YcmCompleter GoToDefinitionElseDeclaration<CR>
