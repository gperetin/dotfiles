" Most of this is shamelessly stolen from Gary Bernhardt
" I removed all Ruby stuff and added some Python stuff
" Gary's .vimrc is at https://github.com/garybernhardt/dotfiles

" call pathogen#incubate()

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-commentary'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'

" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set nocompatible
" Allow backgrounding buffers without writing them, and remember marks/undo
set hidden
" Remember more commands and search history
set history=10000


" Make tab completion for files/buffers act like bash
set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set linespace=2

" Basic configs
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set incsearch
" set cursorline
set autoindent
set laststatus=2
set showmatch
set switchbuf=useopen
set cmdheight=1
set nonumber
set showtabline=0
set winwidth=79
set shell=bash
set encoding=utf-8

let mapleader=","
" Highlighting search
set hls
" Enable file type detection.
filetype plugin indent on

syntax on

" System clipboard
map <leader>y "*y
" Can't be bothered to understand the difference between ESC and <c-c> in
" insert mode
imap <c-c> <esc>
" Close buffer
map qq :bd<cr>
" Reeealy should get used to this...
inoremap jk <esc>

" Custom autocmds
augroup vimrcEx
    autocmd!
    " For all text files set 'textwidth' to 78 characters
    autocmd FileType text setlocal textwidth=78
    autocmd FileType markdown setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

    autocmd FileType python,javascript,html,htmldjango set sw=4 sts=4 et
    autocmd FileType ruby,haml,eruby,yaml,jade set ai sw=2 sts=2 et

    autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:&gt;
    autocmd BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:&gt;

    autocmd BufWritePre *.py :%s/\s\+$//e
augroup END

" Set the color scheme
set t_Co=256
set background=dark
colorscheme grb256

" Use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" Put useful info in status line
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
:hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red


" ctrlp config
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 10

" TAB key autocompletes or indents
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<tab>"
"     else
"         return "\<c-p>"
"     endif
" endfunction
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" inoremap <s-tab> <c-n>

let g:SuperTabDefaultCompletionType = "<c-p>"
au FileType ocaml call SuperTabSetDefaultCompletionType("<c-x><c-o>")
" au FileType ocaml setl sw=2 sts=2 et

" Rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make <leader>' switch between ' and "
nnoremap <leader>' ""yls<c-r>={'"': "'", "'": '"'}[@"]<cr><esc>

map <leader>gt :CtrlPTag<cr>
map <leader>f :CtrlP<cr>
map <leader>F :CtrlP %%<cr>
map <leader>b :CtrlPBuffer<cr>

nnoremap <leader><leader> <c-^>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Not cool using these...
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Open files that are modified in git
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\)" | cut -d " " -f 3')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "e " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()


" Exclude from ctrlp search
let g:ctrlp_custom_ignore = {
    \ 'dir':  'utils/node_modules\|\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.jpg$\|\.png$\|\.pyc$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Running tests
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run test for this file (requires nose Python package)
function! RunTestsForCurrentFile()
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    exec ":! ./manage.py test %"
endfunction

" Run all tests (requires fabric and nose Python packages)
function! RunAllTests()
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    exec ":! ./manage.py test"
endfunction

map <leader>a :call RunTestsForCurrentFile()<cr>
map <leader>z :call RunAllTests()<cr>

let g:syntastic_python_checkers=[]

" OCaml Merlin
let s:ocamlmerlin=substitute(system('opam config var share'),'\n$','','''') .  "/ocamlmerlin"
execute "set rtp+=".s:ocamlmerlin."/vim"
execute "set rtp+=".s:ocamlmerlin."/vimbufsync"

let g:syntastic_ocaml_checkers = ['merlin']

let g:airline_left_sep=''
let g:airline_right_sep=''

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
