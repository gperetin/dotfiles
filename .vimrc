filetype off

" Activate pathogen
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

" -------- BASIC ---------
set nocompatible    " no vi compatibility
set ruler           " Show position in file
set number          " Show line numbers
set encoding=utf-8
set autoindent
set showmode
set showcmd
set hidden
set ttyfast
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set shell=/bin/bash
set lazyredraw
set matchtime=3
set showbreak=↪
set fillchars=diff:⣿
set shiftround
set title
set history=1000

" Make backspace and cursor keys wrap accordingly"
set whichwrap+=<,>,h,l

" resize splits
au VimResized * exe "normal! \<c-w>="

" Statr in 256 color mode
set t_Co=256

set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" Use 4 spaces for tabs, turn on automatic indenting
set tabstop=4
set smarttab
set shiftwidth=4
set softtabstop=4
set wrap
set textwidth=80
set formatoptions=qrn1
set expandtab
set backspace=start,indent
set backspace=2
set colorcolumn=+1

syntax on
set background=dark
" colorscheme molokai
colorscheme grb256

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'"

let mapleader = ","

" Statusline
augroup ft_statuslinecolor
    au!

    au InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
    au InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907
augroup END

set statusline=%f    " Path.
set statusline+=%m   " Modified flag.
set statusline+=%r   " Readonly flag.
set statusline+=%w   " Preview window flag.

set statusline+=\    " Space.

set statusline+=%#redbar#                " Highlight the following as a warning.
"set statusline+=%{SyntasticStatuslineFlag()} " Syntastic errors.
set statusline+=%*                           " Reset highlighting.

set statusline+=%=   " Right align.

" File format, encoding and type.  Ex: "(unix/utf-8/python)"
set statusline+=(
set statusline+=%{&ff}                        " Format (unix/DOS).
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding(utf-8).
set statusline+=/
set statusline+=%{&ft}                        " Type (python).
set statusline+=")

" Line and column position and counts.
set statusline+=\ (line\ %l\/%L,\ col\ %03c))"


" Turn on highlighted search and syntax highlighting
set hlsearch
set ignorecase
set smartcase
set showmatch
set incsearch
set scrolloff=3
set sidescroll=1
set sidescrolloff=10
set virtualedit+=block

noremap <leader><space> :noh<cr>:call clearmatches()<cr>

noremap H ^
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

syntax enable

set cursorline 

" ----------- Folding -------------
set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za
nnoremap <leader>z zMzvzz

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()"

" Disable unused keys
noremap  <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap K <nop>
inoremap # X<BS>#

" Font
if has("gui_running")
    " set guifont=Droid\ Sans\ Mono\ Slashed\ 12
    set guifont=Inconsolata-g\ 12
    set linespace=0
    set go-=r
    set go-=R
    set go-=l
    set go-=L
    set go-=t
    set go-=T
    set go-=m
    set guioptions=aiA
    " Different cursors for different modes.
    set guicursor=n-c:block-Cursor-blinkon0
    set guicursor+=v:block-vCursor-blinkon0
    set guicursor+=i-ci:ver20-iCursor"
    set fillchars+=vert:│

    if has("gui_macvim")
        set guifont=Inconsolata-g:h14
    end
endif


" Disable cursor blinking
set guicursor+=a:blinkon0

" Set leader to comma

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

" Faster Esc
inoremap jk <esc>"
imap <c-c>f <esc>

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

set wildignore+=*.pyc,*.o,*.git,.hg.svn


augroup ft_html
    au!

    au BufNewFile,BufRead *.html setlocal filetype=htmldjango
    au FileType html,jinja,htmldjango setlocal foldmethod=manual

    " Use <localleader>f to fold the current tag.
    au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf

    " Use Shift-Return to turn this:
    "     <tag>|</tag>
    "
    " into this:
    "     <tag>
    "         |
    "     </tag>
    au FileType html,jinja,htmldjango nnoremap <buffer> <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>


    " Django tags
    au FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

    " Django variables
    au FileType jinja,htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>
augroup END

augroup ft_javascript
    au!

    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
augroup END

augroup ft_markdown
    au!

    au BufNewFile,BufRead *.m*down setlocal filetype=markdown

    " Use <localleader>1/2/3 to add headings.
    au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
    au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
    au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
augroup END"

augroup ft_python
    au!

    au Filetype python noremap  <buffer> <localleader>rr :RopeRename<CR>
    au Filetype python vnoremap <buffer> <localleader>rm :RopeExtractMethod<CR>
    au Filetype python noremap  <buffer> <localleader>ri :RopeOrganizeImports<CR>

    au FileType python setlocal omnifunc=pythoncomplete#Complete
    au FileType python setlocal define=^\s*\\(def\\\\|class\\)
    "au FileType python compiler nosetests
    au FileType man nnoremap <buffer> <cr> :q<cr>
augroup END

augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END


let g:indentguides_state = 0
function! IndentGuides() " {{{
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction " "}}}
nnoremap <leader>i :call IndentGuides()<cr>"


" Pulse ------------------------------------------------------------------- {{{
"
function! PulseCursorLine()
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
    silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#2a2a2a ctermbg=233
    redraw
    sleep 20m

    hi CursorLine guibg=#333333 ctermbg=235
    redraw
    sleep 20m

    hi CursorLine guibg=#3a3a3a ctermbg=237
    redraw
    sleep 20m

    hi CursorLine guibg=#444444 ctermbg=239
    redraw
    sleep 20m

    hi CursorLine guibg=#3a3a3a ctermbg=237
    redraw
    sleep 20m

    hi CursorLine guibg=#333333 ctermbg=235
    redraw
    sleep 20m

    hi CursorLine guibg=#2a2a2a ctermbg=233
    redraw
    sleep 20m

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
endfunction

" "}}}"

" Keep search matches in the middle of the window and pulse the line when moving
" " to them.
nnoremap n nzzzv:call PulseCursorLine()<cr>
nnoremap N Nzzzv:call PulseCursorLine()<cr>
