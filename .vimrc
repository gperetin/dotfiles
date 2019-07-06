set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'chriskempson/base16-vim'
Plug 'plasticboy/vim-markdown'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

filetype plugin indent on    " required
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" #########################
" ##### Basic configs #####
" #########################

set nocompatible
" Allow backgrounding buffers without writing them, and remember marks/undo
set hidden
" Remember more commands and search history
set history=10000

" Open all folds by default
set foldlevel=20

" Make tab completion for files/buffers act like bash
set wildmenu

" Searching
" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase
set incsearch
set showmatch

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set linespace=2

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
" set cursorline " This is nice, but usually too slow
set autoindent
set laststatus=2
set switchbuf=useopen
set cmdheight=1
set nonumber
set showtabline=0
set title
set winwidth=79
set shell=zsh
set encoding=utf-8
set ttyfast
set wrap
set gdefault

set backup
set noswapfile

let mapleader=","
set hls

syntax on
set termguicolors
set background=dark
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
let g:solarized_termcolors = 16

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

    autocmd FileType python,javascript,html,htmldjango set sw=2 sts=2 et
    autocmd FileType ruby,haml,eruby,yaml,jade set ai sw=2 sts=2 et

    " autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:&gt;
    " autocmd BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:&gt;
    " autocmd BufRead *.md set ai formatoptions=tcroqn2 comments=n:&gt;
    au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,README.md  setf markdown

    autocmd BufWritePre *.py,*.ml :%s/\s\+$//e
augroup END


" Use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" Put useful info in status line
" :set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
":hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red


" ctrlp config
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 10
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'


let g:SuperTabDefaultCompletionType = "<c-p>"
au FileType ocaml call SuperTabSetDefaultCompletionType("<c-x><c-o>")
au FileType ocaml setl sw=2 sts=2 et

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
map <leader>f :GFiles<cr>
map <leader>F :CtrlP %%<cr>
map <leader>b :CtrlPBuffer<cr>
map <leader>m :CtrlPMRU<cr>

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

let g:syntastic_python_checkers=[]


let g:syntastic_ocaml_checkers = ['merlin']

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
map <leader>c :SyntasticCheck<cr>

let g:airline_left_sep=''
let g:airline_right_sep=''

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set tags=./tags;/,tags;/


" FZF config
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_buffers_jump = 1
