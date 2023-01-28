local lsp = require('lsp-zero')
local rt = require('rust-tools')

local flo_utils = require('flo.utils')

lsp.preset('recommended')

lsp.skip_server_setup({'rust_analyzer'})

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({select = true}),
  ['<C-Space>'] = cmp.mapping.complete(),
})

-- Getting codelldb to work with rust-analyzer
--
-- local extension_path = flo_utils.concatToPath(
--   flo_utils.getHomeDirectory(), 
--   '.vscode', 
--   'extensions', 
--   'vadimcn.vscode-lldb-1.8.1'
-- );
--
local codelldb_path = flo_utils.getMasonPackagePath('codelldb');
local extension_path = flo_utils.concatToPath(codelldb_path, "extension");

local codelldb_path = flo_utils.concatToPath(
  extension_path, 
  'adapter', 
  'codelldb'
);

local ext = ".so";
if flo_utils.isWindows() then
  ext = ".lib";
end

local liblldb_path = flo_utils.concatToPath(
  extension_path,
  "lldb",
  "lib",
  "liblldb" .. ext
);


-- rust-tools server config which gets merged with lsp-zero config
local rt_opts = {
  on_attach = function(_, bufnr)
    vim.keymap.set('n', '<leader>th', rt.hover_actions.hover_actions, {buffer = bufnr})
  end
}


local rust_lsp = lsp.build_options('rust_analyzer', rt_opts)

require('rust-tools').setup({
  server = rust_lsp,
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
      codelldb_path,
      liblldb_path
    )
  }
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

-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
