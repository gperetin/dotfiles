syntax on

call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

call plug#end()

" Apparently, these 2 speed things up (esp with NERDTree) and I don't use them anyways
set noshowcmd
set noruler

" Remember more commands and search history
set history=10000

set ignorecase
set smartcase
set showmatch
set linespace=2
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set switchbuf=useopen
set showtabline=0
set fileencoding=utf-8
set gdefault
set backup
set noswapfile

let mapleader=","

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

set termguicolors
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox

" Close buffer
map qq :bd<cr>

" Use <Tab> and <S-Tab> to navigate popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use C-j and C-k to navigate popup menu
inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set shortmess+=c

" Manually trigger completion
let g:completion_enable_auto_popup = 0
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

lua <<EOF
-- Check here to see the options we can pass to rust-analyzer
-- https://github.com/neovim/nvim-lspconfig#rust_analyzer
require'lspconfig'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }
EOF

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" LSP keyboard shortcuts
nnoremap <silent> <c-p> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> R <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <c-h> <cmd>lua vim.lsp.buf.rename()<CR>

" Make escape work in the Neovim terminal.
" Turned off for now - this messed with the open file dialog
" tnoremap <Esc> <C-\><C-n>

" Prefer Neovim terminal insert mode to normal mode.
autocmd BufEnter term://* startinsert

" Mouse scrolling
set mouse=a

" Movement across panels
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" - Check here https://blog.ffff.lt/posts/neovim-native-lsp-support-attempt-1/
" and set some shortcuts for completion
" - Install telescope
" - Move shortcuts from .vimrc such as find file, run tests, etc.
" - configure inline type hints (has to be somewhere in LSP config)

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''

" Run tests for current Python file
function! RunTestsForCurrentFile()
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    exec ":! make test-file filepath=%"
endfunction

function! RunAllTests()
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    exec ":! make test"
endfunction

map <leader>t :call RunTestsForCurrentFile()<cr>
map <leader>a :call RunAllTests()<cr>
