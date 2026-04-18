local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

return {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_markers = { 'zls.json', 'build.zig', '.git' },
  workspace_required = false,
  capabilities = capabilities,
}
