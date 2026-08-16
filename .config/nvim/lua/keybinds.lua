local function close_buffer()
  local listed_buffers = vim.tbl_filter(function(buf)
    return vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())

  if #listed_buffers <= 1 then
    vim.cmd("quitall")
  else
    vim.cmd("bdelete")
  end
end

vim.keymap.set("n", "qq", close_buffer, { desc = "Close buffer" })
vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Alternate buffer" })
vim.keymap.set("n", "<CR>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

vim.keymap.set("n", "<C-n>", function()
  MiniFiles.open(vim.fn.getcwd(), false)
end, { desc = "Open file explorer" })

vim.keymap.set("n", "<leader>f", function()
  MiniPick.builtin.files()
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>F", function()
  MiniExtra.pickers.git_files({ scope = "modified" })
end, { desc = "Find modified Git files" })

vim.keymap.set("n", "<leader>d", "<cmd>CodeDiff<CR>", { desc = "Open CodeDiff" })

vim.keymap.set("n", "<leader>b", function()
  MiniPick.builtin.buffers()
end, { desc = "Find buffers" })

vim.keymap.set("n", "<leader>cd", function()
  MiniExtra.pickers.diagnostic({ scope = "current" })
end, { desc = "Current buffer diagnostics" })

local function ty_check()
  local root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }
  local root = vim.fs.root(vim.fn.getcwd(), root_markers) or vim.fn.getcwd()

  vim.system({ "uv", "run", "ty", "check", "--output-format", "concise", "--color", "never" }, {
    cwd = root,
    text = true,
  }, function(result)
    vim.schedule(function()
      local items = {}
      for line in (result.stdout .. "\n" .. result.stderr):gmatch("[^\r\n]+") do
        local path, lnum, col, severity, rule, message = line:match("^(.-):(%d+):(%d+): (%a+)%[([^%]]+)%] (.+)$")
        if path ~= nil then
          table.insert(items, {
            filename = vim.fs.joinpath(root, path),
            lnum = tonumber(lnum),
            col = tonumber(col),
            type = severity == "error" and "E" or "W",
            text = string.format("[%s] %s", rule, message),
          })
        end
      end

      vim.fn.setqflist({}, "r", { title = "ty check", items = items })
      if #items == 0 then
        vim.notify("ty check found no diagnostics")
        return
      end

      MiniExtra.pickers.list({ scope = "quickfix" })
    end)
  end)
end

vim.keymap.set("n", "<leader>cD", ty_check, { desc = "Project diagnostics" })

vim.keymap.set("n", "<leader>s", function()
  MiniExtra.pickers.lsp({ scope = "document_symbol" })
end, { desc = "Search buffer symbols" })

vim.keymap.set("n", "<leader>S", function()
  MiniExtra.pickers.lsp({ scope = "workspace_symbol_live" })
end, { desc = "Search workspace symbols" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "Hover documentation" })

local rename_snapshot
local function save_renamed_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local changedtick = vim.api.nvim_buf_get_changedtick(buf)
    local was_changed = rename_snapshot[buf] == nil or rename_snapshot[buf] ~= changedtick
    if was_changed and vim.bo[buf].modified and vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("write")
      end)
    end
  end
end

vim.api.nvim_create_autocmd("LspRequest", {
  callback = function(args)
    local request = args.data.request
    if rename_snapshot == nil or request.method ~= "textDocument/rename" or request.type ~= "complete" then
      return
    end

    vim.schedule(function()
      save_renamed_buffers()
      rename_snapshot = nil
    end)
  end,
})

local function rename_and_save()
  if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/rename" }) == 0 then
    vim.notify("No LSP client supports rename", vim.log.levels.WARN)
    return
  end

  rename_snapshot = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    rename_snapshot[buf] = vim.api.nvim_buf_get_changedtick(buf)
  end
  vim.lsp.buf.rename()
end

vim.keymap.set("n", "<leader>cn", rename_and_save, { desc = "Rename symbol" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "grh", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "grr", function()
  MiniExtra.pickers.lsp({ scope = "references" })
end, { desc = "Find references" })

local function completion_navigation(popup_key, fallback_key)
  return function()
    return vim.fn.pumvisible() == 1 and popup_key or fallback_key
  end
end

vim.keymap.set("i", "<C-j>", completion_navigation("<C-n>", "<C-j>"), { expr = true })
vim.keymap.set("i", "<C-k>", completion_navigation("<C-p>", "<C-k>"), { expr = true })
vim.keymap.set("i", "<Tab>", completion_navigation("<C-n>", "<Tab>"), { expr = true })
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
    return "<C-y>"
  end
  return "<CR>"
end, { expr = true })
