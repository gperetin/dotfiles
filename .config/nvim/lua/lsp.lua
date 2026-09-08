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

local function ruff_organize_imports(client, bufnr)
  local function request(method, params)
    local response, err = client:request_sync(method, params, 3000, bufnr)
    if response == nil or response.err ~= nil then
      vim.notify("Ruff organize imports failed: " .. vim.inspect(err or (response and response.err)), vim.log.levels.WARN)
      return nil
    end
    return response.result
  end

  local kind = "source.organizeImports.ruff"
  local actions = request("textDocument/codeAction", {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
    range = { start = { line = 0, character = 0 }, ["end"] = { line = 0, character = 0 } },
    context = { only = { kind }, diagnostics = {} },
  })

  for _, action in ipairs(actions or {}) do
    if action.kind == kind and not action.disabled then
      if action.edit == nil and client:supports_method("codeAction/resolve", bufnr) then
        action = request("codeAction/resolve", action)
      end
      if action ~= nil and not action.disabled and action.edit ~= nil then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      end
    end
  end
end

local ruff_save_group = vim.api.nvim_create_augroup("RuffOnSave", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = ruff_save_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil or client.name ~= "ruff" then
      return
    end

    vim.api.nvim_clear_autocmds({ group = ruff_save_group, buffer = args.buf, event = "BufWritePre" })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = ruff_save_group,
      buffer = args.buf,
      callback = function()
        if not vim.lsp.buf_is_attached(args.buf, client.id) then
          return
        end
        -- Check capabilities here: Ruff can register formatting after LspAttach.
        -- Finish import edits before formatting and writing the buffer to disk.
        if client:supports_method("textDocument/codeAction", args.buf) then
          ruff_organize_imports(client, args.buf)
        end
        if client:supports_method("textDocument/formatting", args.buf) then
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 3000 })
        end
      end,
    })
  end,
})

vim.lsp.enable({ "ty", "ruff", "rust_analyzer" })
