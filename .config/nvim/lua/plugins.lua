-- Neovim's built-in vim.pack manager. Add plugin specs to this list later.
local plugins = {
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/echasnovski/mini.nvim", name = "mini.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
  { src = "https://github.com/esmuellert/codediff.nvim", name = "codediff.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope.nvim" },
}

vim.pack.add(plugins)

vim.cmd.colorscheme("catppuccin-mocha")

local inlay_hint_hl = vim.api.nvim_get_hl(0, { name = "LspInlayHint", link = false })
inlay_hint_hl.bg = nil
inlay_hint_hl.italic = true
vim.api.nvim_set_hl(0, "LspInlayHint", inlay_hint_hl)

require("codediff").setup()
require("telescope").setup({})

require("mini.icons").setup()
require("mini.git").setup()
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniGitUpdated",
  callback = function(args)
    local summary = vim.b[args.buf].minigit_summary or {}
    vim.b[args.buf].minigit_summary_string = summary.head_name or ""
  end,
})
require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "▎", change = "▎", delete = "▎" },
  },
})

local statusline = require("mini.statusline")
statusline.setup({
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local git = statusline.section_git({ trunc_width = 40 })
      local diff = statusline.section_diff({ trunc_width = 75 })
      local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
      local filename = statusline.section_filename({ trunc_width = 140 })

      local filetype = vim.bo.filetype
      if filetype ~= "" then
        local icon = MiniIcons.get("filetype", filetype)
        filetype = icon .. " " .. filetype
      end
      local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
      local fileinfo = table.concat({ encoding, vim.bo.fileformat, filetype }, " ")

      return statusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
        "%<",
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=",
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { "%l:%c" } },
      })
    end,
    inactive = function()
      local filename = statusline.section_filename({ trunc_width = 140 })
      return statusline.combine_groups({
        { hl = "MiniStatuslineInactive", strings = { filename } },
        "%=",
        { hl = "MiniStatuslineInactive", strings = { "%l:%c" } },
      })
    end,
  },
  use_icons = true,
})

require("mini.files").setup({
  content = {
    filter = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".") and fs_entry.name ~= "__pycache__"
    end,
  },
  mappings = {
    close = "<Esc>",
    go_in_plus = "<CR>",
  },
})

require("mini.pick").setup({
  mappings = {
    move_down = "<C-j>",
    move_up = "<C-k>",
  },
})

require("mini.extra").setup()

require("mini.completion").setup({
  delay = {
    -- Debounce typing, including LSP trigger characters such as '.'.
    completion = 100,
  },
  -- Keep default LSP processing so labelDetails show type/module origins.
  window = {
    info = { border = "rounded" },
    signature = { border = "rounded" },
  },
})

local treesitter = require("nvim-treesitter")
treesitter.setup()

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

if vim.fn.executable("tree-sitter") == 1 then
  treesitter.install({ "python" })
end

require("mini.clue").setup({
  triggers = {
    { mode = "n", keys = "<Leader>" },
    { mode = "n", keys = "gr" },
  },
})
