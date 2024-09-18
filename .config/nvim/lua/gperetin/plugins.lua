local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'folke/tokyonight.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
    'goolord/alpha-nvim',
    'nvim-telescope/telescope.nvim',
    "folke/which-key.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-lualine/lualine.nvim',
    'nvim-tree/nvim-tree.lua',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'ray-x/lsp_signature.nvim',
    'onsails/lspkind.nvim',
    'L3MON4D3/LuaSnip',
    'hrsh7th/nvim-cmp',
    'windwp/nvim-autopairs',
    'neovim/nvim-lspconfig',
    'numToStr/Comment.nvim',
    'lewis6991/gitsigns.nvim',
    'TimUntersberger/neogit',
    {'nvim-neotest/neotest', dependencies = {{
        'nvim-neotest/neotest-python',
        'nvim-neotest/nvim-nio'
    }}},
    {"williamboman/mason.nvim", build = ":MasonUpdate"},  -- :MasonUpdate updates registry contents
}


local opts = {}
require("lazy").setup(plugins, opts)

-- Plugin configurations
-- Theme
require("tokyonight").setup({
    styles = {
        keywords = { italic = false },
    },
    on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
            bg = prompt,
        }
        hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
    end,
})

vim.o.background = "dark"
vim.cmd([[colorscheme tokyonight]])


-- Treesitter
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "python", "lua", "rust", "html", "css" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
    },
    indent = {
        enable = true
    }
}


-- Greeter
require'alpha'.setup(require'alpha.themes.startify'.config)

-- Which Key
require("which-key").setup()

-- NvimTree
require("nvim-tree").setup({
    filters = {
        custom = { '.git$', 'node_modules$', '^target$' },
    },
})
vim.keymap.set('n', '<C-n>', '<CMD>NvimTreeToggle<CR>')

-- Autopairs
require("nvim-autopairs").setup()

-- Commen.nvim
require('Comment').setup()

-- Gitsigns
require('gitsigns').setup()

-- Neogit
require('neogit').setup({
    auto_refresh = true,
})

-- Neotest
require("neotest").setup({
    adapters = {
        require("neotest-python")({
            dap = { justMyCode = false },
        }),
    },
})

-- Mason
require("mason").setup()
