local python_root_markers = {
  "pyrightconfig.json",
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  ".git",
}

vim.lsp.config("ruff", {
  capabilities = MiniCompletion.get_lsp_capabilities(),
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = python_root_markers,
})

local ty_root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }

vim.lsp.config("ty", {
  capabilities = MiniCompletion.get_lsp_capabilities(),
  cmd = { "uv", "run", "ty", "server" },
  filetypes = { "python" },
  root_markers = ty_root_markers,
})

vim.lsp.config("rust_analyzer", {
  capabilities = MiniCompletion.get_lsp_capabilities(),
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
})

local rust_inlay_hints_group = vim.api.nvim_create_augroup("RustInlayHints", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = rust_inlay_hints_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil and client.name == "rust_analyzer" and client:supports_method("textDocument/inlayHint", args.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

local format_group = vim.api.nvim_create_augroup("RuffFormat", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = format_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil or client.name ~= "ruff" or not client:supports_method("textDocument/formatting", args.buf) then
      return
    end

    vim.api.nvim_clear_autocmds({ group = format_group, buffer = args.buf, event = "BufWritePre" })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_group,
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({
          bufnr = args.buf,
          timeout_ms = 3000,
          filter = function(format_client)
            return format_client.name == "ruff"
          end,
        })
      end,
    })
  end,
})

vim.lsp.enable({ "ty", "ruff", "rust_analyzer" })
