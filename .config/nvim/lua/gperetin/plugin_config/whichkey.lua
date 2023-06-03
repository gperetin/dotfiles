local finders = require('telescope.builtin')

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
    ["<leader>ch"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    ["<leader>cn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    ["<leader>cd"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show line diagnostics" },
    ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
})
