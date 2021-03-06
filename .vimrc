set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'morhetz/gruvbox'

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
set t_Co=256
set termguicolors
set background=dark
autocmd vimenter * colorscheme gruvbox
colorscheme gruvbox

" System clipboard
map <leader>y "*y
" Can't be bothered to understand the difference between ESC and <c-c> in
" insert mode
imap <c-c> <esc>
" Close buffer
map qq :bd<cr>

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

    " autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:&gt;
    " autocmd BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:&gt;
    " autocmd BufRead *.md set ai formatoptions=tcroqn2 comments=n:&gt;
    au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,README.md  setf markdown

    autocmd BufWritePre *.py,*.ml :%s/\s\+$//e
augroup END


" Use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

let g:SuperTabDefaultCompletionType = "<c-p>"

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

" MRU file search
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

map <leader>f :GFiles<cr>
map <leader>F :Files<cr>
map <leader>b :Buffers<cr>
map <leader>m :FZFMru<cr>

" Search for the word under cursor
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

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

" Find word under cursor using Rg + fzf
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('right:50%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_symbols.branch = ''

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set tags=./tags;/,tags;/

" Neovim
if has("nvim")
  " Make escape work in the Neovim terminal.
  tnoremap <Esc> <C-\><C-n>

  " Prefer Neovim terminal insert mode to normal mode.
  autocmd BufEnter term://* startinsert

  " Mouse scrolling
  set mouse=a
endif

" FZF config
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_buffers_jump = 1

highlight Pmenu ctermfg=13 ctermbg=0 guifg=#87ffff guibg=#000000
highlight PmenuSel ctermfg=13 ctermbg=0 guifg=#ff5fd7 guibg=#000000

" highlight YcmErrorLine guibg=NONE
" highlight YcmWarningLine guibg=NONE
" highlight YcmErrorSection  guibg=#303030 guisp=#ff0000 gui=undercurl
" highlight YcmErrorSection gui=undercurl guisp=#ff0000 cterm=underline guifg=#ff0087
" highlight YcmWarningSection guisp=#ff0000 cterm=undercurl ctermbg=8 ctermfg=11 guifg=#af8700
" highligh YcmErrorSign guibg=NONE guifg=#ff0087
" highligh YcmWarningSign guibg=NONE guifg=#af8700

" highlight SignColumn guibg=NONE


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
