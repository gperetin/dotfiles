syntax on

call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'neovim/nvim-lspconfig'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-cmdline'

" Needed for telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end() " Apparently, these 2 speed things up (esp with NERDTree) and I don't use them anyways
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
" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backup
set noswapfile

let mapleader=","

" Alternate window
nnoremap <leader><leader> <c-^>

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
" imap <Tab> <Plug>(completion_smart_tab)
" imap <S-Tab> <Plug>(completion_smart_s_tab)

" Setup nvim-cmp
lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-c>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),

      -- From TJ Devries, https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/after/plugin/completion.lua#L69
      -- If you want tab completion :'(
      -- First you have to just promise to read `:help ins-completion`.
      ["<Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ["<S-Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'path' },
    }, {
    }, {
      { name = 'buffer', keyword_length = 4 },
    })
  })

  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline', keyword_length = 3 }
    })
  })

  -- Setup lspconfig
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }
EOF


lua <<EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
EOF

lua <<EOF

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  }
}

EOF

nnoremap <silent> <Leader>f :lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({ winblend = 5 }))<CR>
map <Leader>b :Buffers<CR>

" MRU file search
" This is the only feature for which we still use FZF.
" This could be replaced with Telescope's oldfiles, but I like it that we can
" pass in some options here.
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})
map <Leader>m :FZFMru<cr>


" Search for word under cursor
nnoremap <silent> <Leader>rg :lua require'telescope.builtin'.grep_string()<CR>

" Search in quickfix
nnoremap <silent> <Leader>q :lua require'telescope.builtin'.quickfix()<CR>

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" LSP keyboard shortcuts
nnoremap <silent> <c-p> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-e> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> R <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <c-t> <cmd>lua vim.lsp.buf.rename()<CR>

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
