-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({
    function(use)
        use('wbthomason/packer.nvim')
        use('nvim-lua/plenary.nvim')
        use('nvim-lua/popup.nvim')

        use({
            'folke/tokyonight.nvim',
            config = function()
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

            end
        })

        use({
            {
                'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate',
                config = function()
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

                end
            },
            { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
            { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
            { 'nvim-treesitter/nvim-treesitter-context', after = 'nvim-treesitter' },
        })

        use({
            'kyazdani42/nvim-web-devicons',
            config = function()
                require('nvim-web-devicons').setup()
            end,
        })

        use ({
            'goolord/alpha-nvim',
            requires = { 'kyazdani42/nvim-web-devicons' },
            config = function ()
                require'alpha'.setup(require'alpha.themes.startify'.config)
            end
        })

        use({
            {
                'nvim-telescope/telescope.nvim', tag = '0.1.0',
                config = function()
                    local finders = require('telescope.builtin')
                    local actions = require('telescope.actions')

                    require('telescope').setup {
                        defaults = {
                            mappings = {
                                i = {
                                    ["<C-j>"] = actions.move_selection_next,
                                    ["<C-k>"] = actions.move_selection_previous,
                                }
                            },
                            layout_config = {
                                width = 148,
                                preview_width = 0.6
                            },
                            prompt_prefix = "   ",
                            selection_caret = "  ",
                            entry_prefix = "  ",
                        }
                    }


                    local wk = require("which-key")
                    wk.register({
                        ["<leader>f"] = { function()
                            local ok = pcall(finders.git_files, { show_untracked = true })
                            if not ok then
                                finders.find_files()
                            end
                        end, "Find File"
                        },
                        ["<leader>d"] = { function() finders.diagnostics({bufnr=0}) end, "Buffer Diagnostics" },
                        ["<leader>b"] = { function() finders.buffers() end, "Buffers" },
                        ["<leader>g"] = { function() finders.live_grep() end, "Live Grep" },
                        ["<leader>c"] = { name = "+code" },
                        ["<leader>cp"] = { function() finders.lsp_definitions({jump_type='vsplit'}) end, "Jump to definition" },
                        ["<leader>cr"] = { function() finders.lsp_references() end, "References" },
                    })
                end
            },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                after = 'telescope.nvim',
                run = 'make',
                config = function()
                    require('telescope').load_extension('fzf')
                end,
            }
        })

        use ({
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup {
                    -- your configuration comes here
                }
            end
        })

        use({
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = function()
                require('lualine').setup {
                    options = {
                        icons_enabled = true,
                        theme = 'auto',
                        component_separators = { left = '', right = ''},
                        section_separators = { left = '', right = ''},
                        disabled_filetypes = {},
                        always_divide_middle = true,
globalstatus = false,
                    },
                    sections = {
                        lualine_a = {'mode'},
                        lualine_b = {'branch', 'diff', 'diagnostics'},
                        lualine_c = {'filename'},
                        lualine_x = {'encoding', 'fileformat', 'filetype'},
                        lualine_y = {'progress'},
                        lualine_z = {'location'}
                    },
                    inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = {'filename'},
                        lualine_x = {'location'},
                        lualine_y = {},
                        lualine_z = {}
                    },
                    tabline = {},
                    extensions = {}
                }
            end
        })

        use({
            'kyazdani42/nvim-tree.lua',
            requires = { 'kyazdani42/nvim-web-devicons', },
            config = function()
                require("nvim-tree").setup({
                    filters = {
                        custom = { '.git$', 'node_modules$', '^target$' },
                    },
                })
            end,
            vim.keymap.set('n', '<C-n>', '<CMD>NvimTreeToggle<CR>')
        })

        use('hrsh7th/cmp-path')
        use('hrsh7th/cmp-buffer')
        use('hrsh7th/cmp-nvim-lsp')
        use('ray-x/lsp_signature.nvim')
        use('onsails/lspkind.nvim')

        use("L3MON4D3/LuaSnip")

        use({
            'hrsh7th/nvim-cmp',
            config = function()
                require "lsp_signature".setup({
                    floating_window = false,
                    hint_prefix = ' ',
                })

                local lspkind = require('lspkind')

                local cmp = require'cmp'
                cmp.setup {
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body)
                        end
                    },
                    mapping = {
                        ['<C-j>'] = cmp.mapping.select_next_item(),
                        ['<C-k>'] = cmp.mapping.select_prev_item(),
                        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                        ['<C-c>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                        ['<C-e>'] = cmp.mapping({
                            i = cmp.mapping.abort(),
                            c = cmp.mapping.close(),
                        }),

                        -- From TJ Devries, https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/after/plugin/completion.lua#L69
                        -- If you want tab completion
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
                        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    },

                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                        { name = 'path' },
                        { name = 'buffer', keyword_length = 4 },
                    }),

                    completion = {
                        keyword_length = 2
                    },

                    formatting = {
                        format = lspkind.cmp_format({
                            mode = 'symbol_text',
                            maxwidth = 50, -- prevent the popup from showing more than provided characters
                            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        })
                    },

                    experimental = {
                        native_menu = false,
                    }

                }

                cmp.setup.cmdline(':', {
                    sources = cmp.config.sources({
                        { name = 'path' }
                    }, {
                            { name = 'cmdline', keyword_length = 3 }
                        })
                })
            end
        })

        use {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup { }
                local cmp_autopairs = require('nvim-autopairs.completion.cmp')
                local cmp = require('cmp')
                cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
            end
        }

        use({
            'neovim/nvim-lspconfig',
            config = function()
                -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
                local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

                require('lspconfig')['pyright'].setup {
                    capabilities = capabilities
                }
                require('lspconfig')['rust_analyzer'].setup {
                    capabilities = capabilities
                }

                -- vim.keymap.set('n', '<C-p>', vim.lsp.buf.definition)
                vim.keymap.set('n', '<C-e>', vim.lsp.buf.hover)
                vim.keymap.set('n', '<C-t>', vim.lsp.buf.rename)
                vim.keymap.set('n', '<C-d>', vim.diagnostic.open_float)

                vim.diagnostic.config({
                    virtual_text = false,
                    signs = {
                        active = signs
                    },
                    severity_sort = true,
                    float = {
                        focusable = false,
                        source = "always",  -- Or "if_many"
                    },
                })
                vim.fn.sign_define("DiagnosticSignError", {text="", texthl="DiagnosticSignError", numhl="DiagnosticSignError"})
                vim.fn.sign_define("DiagnosticSignWarn", {text="", texthl="DiagnosticSignWarn", numhl="DiagnosticSignWarn"})
                vim.fn.sign_define("DiagnosticSignHint", {text="", texthl="DiagnosticSignHint", numhl="DiagnosticSignHint"})
                vim.fn.sign_define("DiagnosticSignInfo", {text="", texthl="DiagnosticSignInfo", numhl="DiagnosticSignInfo"})

            end,
            requires = {
                {
                    'hrsh7th/cmp-nvim-lsp',
                },
            },
        })

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        }

        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()
            end
        }

        use { 'TimUntersberger/neogit',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require('neogit').setup({
                    auto_refresh = true,
                })
            end
        }

        use('nvim-neotest/neotest-python')
        use('nvim-neotest/neotest-plenary')
        use({
            'nvim-neotest/neotest',
            config = function()
                require("neotest").setup({
                    adapters = {
                        require("neotest-python")({
                            dap = { justMyCode = false },
                        }),
                        require("neotest-plenary")
                    },
                })
            end
        })

        if packer_bootstrap then
            require('packer').sync()
        end
    end
})
