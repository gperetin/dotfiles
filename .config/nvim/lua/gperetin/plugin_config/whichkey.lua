local finders = require('telescope.builtin')

local wk = require("which-key")
wk.add({
    {"<leader>f", function()
        local ok = pcall(finders.git_files, { show_untracked = true })
        if not ok then
            finders.find_files()
        end
    end, desc = "Find File"
    },
    { "<leader>b", function() finders.buffers() end, desc = "Buffers" },
    { "<leader>c", group = "code" },
    { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
    { "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show line diagnostics" },
    { "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
    { "<leader>cn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
    { "<leader>cp", function() finders.lsp_definitions({jump_type='vsplit'}) end, desc = "Jump to definition" },
    { "<leader>cr", function() finders.lsp_references() end, desc = "References" },
    { "<leader>d", function() finders.diagnostics({bufnr=0}) end, desc = "Buffer Diagnostics" },
    { "<leader>g", function() finders.live_grep() end, desc = "Live Grep" },
})
