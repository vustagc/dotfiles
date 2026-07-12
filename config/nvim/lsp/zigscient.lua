local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

return {
  cmd = {
    "zigscient",
    "--disable-lsp-logs",
    "--config-path",
    vim.fn.expand("~/.config/zls/zls.json"),
  },
  filetypes = { "zig", "zir" },
  root_markers = { "zls.json", "build.zig", ".git" },
  workspace_required = false,
  capabilities = capabilities,
}

-- return {
--   cmd = { 'zigscient --disable-lsp-logs --config-path ~/.config/zls/zls.json' },
--   filetypes = { 'zig', 'zir' },
--   root_markers = { 'zls.json', 'build.zig', '.git' },
--   workspace_required = false,
--   capabilities = capabilities,
-- }
