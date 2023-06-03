local lspkind = require('lspkind')
local cmp = require('cmp')

require 'lsp_signature'.setup({
    floating_window = false,
    hint_prefix = ' ',
})

cmp.setup({
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
    },

})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            { name = 'cmdline', keyword_length = 3 }
        })
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())



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
