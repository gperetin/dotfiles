local g = vim.g
local o = vim.o

g.mapleader = ","

o.showcmd = false
o.ruler = false
o.history = 10000

o.ignorecase = true
o.smartcase = true
o.showmatch = true
o.linespace = 2
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

o.switchbuf = 'useopen'
o.showtabline = 0
o.fileencoding = 'utf-8'
o.gdefault = true

o.backup = false
o.swapfile = false
o.writebackup = false

o.scrolloff = 3
o.termguicolors = true

o.completeopt = 'menuone,noinsert,noselect'

o.clipboard = 'unnamedplus'
o.mouse = 'a'

o.splitright = true

-- Disable these as we're using nvim-tree
g.loaded = 1
g.loaded_netrwPlugin = 1
