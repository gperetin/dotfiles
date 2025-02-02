local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

map('n', 'qq', ':bd<CR>')               -- Close buffer
map('n', '<leader><leader>', '<C-^>')   -- Alternate window
map('n', '<leader>b', ':Buffers<CR>')   -- Buffers
map('n', '<CR>', ':nohlsearch<CR>')     -- Clear search highlights
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Navigate popup menus with Ctrl+J/K
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_nav_down()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<C-j>'
end
function _G.smart_nav_up()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<C-k>'
end
vim.api.nvim_set_keymap('i', '<C-j>', 'v:lua.smart_nav_down()', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-k>', 'v:lua.smart_nav_up()', {expr = true, noremap = true})

