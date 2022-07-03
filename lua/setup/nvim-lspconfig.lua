local ok, nvim_lspconfig = pcall(require, 'nvim-lspconfig')
local coq = require('coq')

if not ok then
  return
end

local map = vim.keymap.set

local servers = {
  'solargraph',
  'eslint',
  'stylelint_lsp',
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
map('n', '<space>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  map('n', 'gD', vim.lsp.buf.declaration, bufopts)
  map('n', 'gd', vim.lsp.buf.definition, bufopts)
  map('n', 'K', vim.lsp.buf.hover, bufopts)
  map('n', 'gi', vim.lsp.buf.implementation, bufopts)
  map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  map('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  map('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  map('n', 'gr', vim.lsp.buf.references, bufopts)
  map('n', '<space>f', vim.lsp.buf.formatting, bufopts)

  --- In lsp attach function
  map("n", "gr", "<cmd>Lspsaga rename<cr>", bufopts)
  map("n", "gx", "<cmd>Lspsaga code_action<cr>", bufopts)
  map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", bufopts)
  map("n", "K",  "<cmd>Lspsaga hover_doc<cr>", bufopts)
  map("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", bufopts)
  map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", bufopts)
  map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", bufopts)
  map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", bufopts)
  map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", bufopts)
end

for _, server in ipairs(servers) do
  nvim_lspconfig[server].setup(coq.lsp_ensure_capabilities {
    on_attach = on_attach,
  })
end
