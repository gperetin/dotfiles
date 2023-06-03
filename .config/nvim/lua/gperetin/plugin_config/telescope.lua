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

require('telescope').load_extension('fzf')
