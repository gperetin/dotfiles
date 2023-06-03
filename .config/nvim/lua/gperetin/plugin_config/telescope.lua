local finders = require('telescope.builtin')
local actions = require('telescope.actions')

require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    },
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

require('telescope').load_extension('fzf')
