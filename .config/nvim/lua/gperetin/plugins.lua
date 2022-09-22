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
        use({
            'ellisonleao/gruvbox.nvim',
            config = function()
                require("gruvbox").setup()
                vim.o.background = "dark"
                vim.cmd([[colorscheme gruvbox]])
            end
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


        use({
            'hrsh7th/nvim-cmp',
            config = function()
                local cmp = require'cmp'
                cmp.setup {
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
                        { name = 'path' },
                    }, {
                        { name = 'buffer', keyword_length = 4 },
                    })

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

        use({
            'neovim/nvim-lspconfig',
            event = 'BufRead',
            config = function()
                local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

                require('lspconfig')['pyright'].setup {
                    capabilities = capabilities
                }
                require('lspconfig')['rust_analyzer'].setup {
                    capabilities = capabilities
                }
            end,
            requires = {
                {
                    -- WARN: Unfortunately we won't be able to lazy load this
                    'hrsh7th/cmp-nvim-lsp',
                },
            },
        })

        if packer_bootstrap then
            require('packer').sync()
        end
    end
})
