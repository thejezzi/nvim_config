local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer'
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local set = vim.keymap.set;

  set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  set('n', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
  set('n', '<leader>vd', function() vim.lsp.buf.type_definition() end, opts)
  set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
  set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
  set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts);

  -- Change diagnostic keys
  set('n', '<leader>dn', function() vim.diagnostic.goto_next() end, opts)
  set('n', '<leader>dp', function() vim.diagnostic.goto_prev() end, opts)


  -- cmp.setup({
  --   mapping = cmp_mappings,
  --   sources = {
  --     {name = 'nvim_lsp'},
  --     {name = 'vsnip'},
  --     {name = 'buffer'},
  --   },
  -- })
end)

lsp.setup()

require'lspconfig'.sumneko_lua.setup {
    -- ... other configs
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

-- vim.diagnostic.config({
--   virtual_text = true,
--   signs = true,
--   update_in_insert = false,
--   underline = true,
--   severity_sort = false,
--   float = true,
-- })

vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
