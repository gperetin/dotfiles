filetype off

" Activate pathogen
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

" no vi compatibility
set nocompatible

" Show position in file
set ruler

" Show line numbers
set number

" Make backspace and cursor keys wrap accordingly"
set whichwrap+=<,>,h,l

" Statr in 256 color mode
set t_Co=256

set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" Use 4 spaces for tabs, turn on automatic indenting
set tabstop=4
set smarttab
set shiftwidth=4
set autoindent
set expandtab
set backspace=start,indent
set backspace=2

set background=dark
colorscheme molokai

" Turn on highlighted search and syntax highlighting
set hlsearch
set incsearch
syntax on
syntax enable

" set cursorline " Commented out due to poor performance

" Font
if has("gui_running")
    " set guifont=Droid\ Sans\ Mono\ Slashed\ 12
    set guifont=Inconsolata-g\ 11
    set go-=r
    set go-=L
    set go-=T
    set go-=m
    set linespace=2
    colorscheme solarized
    if has("mac")
        set fuoptions=maxvert,maxhorz
    endif
endif

" Set leader to comma
let mapleader = ","

" ########### NERDTree ############
noremap  <F2> :NERDTreeToggle<cr>
inoremap <F2> <esc>:NERDTreeToggle<cr>
au Filetype nerdtree setlocal nolist


let g:CommandTMaxHeight=20

map <C-h> :bprevious<CR>
map <C-l> :bnext<CR>
map qq      :bdelete<CR>
inoremap    <S-Enter>   <esc>o
inoremap    ii  <esc>

let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index', 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json', '.*\.o$', 'db.db']

" Restore file position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

set wildignore+=*.pyc,*.o,*.git
