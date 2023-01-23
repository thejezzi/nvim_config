
--[=[

install vscode js debug
```
git clone https://github.com/microsoft/vscode-js-debug ~/.DAP/vscode-js-debug --depth=1
cd $HOME/.DAP/vscode-js-debug
npm install --legacy-peer-deps
npm run compile
```

--]=]

local dap = require('dap')
local dap_utils = require('dap.utils')
local dap_vscode_js = require('dap-vscode-js')

local homedir = os.getenv("HOME");

if homedir == nil then
  homedir = os.getenv("USERPROFILE");
end

function get_plugin_path(plugin_name, opt)
  local data_folder = "~/.config/nvim/init.vim";
  if os.getenv("USERPROFILE") ~= nil then
    data_folder = homedir .. "\\AppData\\Local\\nvim-data";
  end
  local opt_or_start = "start";
  if opt then
    opt_or_start = "opt";
  end
  local path = data_folder .. "/site/pack/packer/" .. opt_or_start .. "/" .. plugin_name;
  return path
end

local ms_vsc_debug_plugin = get_plugin_path('vscode-js-debug', true);

print("ms_vsc_debug_plugin: " .. ms_vsc_debug_plugin);

dap_vscode_js.setup({
  node_path = "node",
  debugger_path = ms_vsc_debug_plugin,
  adapters = {
    "pwa-node",
    "pwa-chrome",
    "pwa-firefox",
    "pwa-msedge",
    "node-terminal",
    "pwa-extensionHost"
  }
})

local exts = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",

  "vue",
  "svelte",
  "astro",
}

for _, ext in ipairs(exts) do
  dap.configurations[ext] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node)",
      cwd = vim.fn.getcwd(),
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node with ts-node)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "--loader", "ts-node/esm" },
      runtimeExecutable = "node",
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node with deno)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
      runtimeExecutable = "deno",
      attachSimplePort = 9229,
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with jest)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
      runtimeExecutable = "node",
      args = { "${file}", "--coverage", "false" },
      rootPath = "${workspaceFolder}",
      sourceMaps = true,
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with vitest)",
      cwd = vim.fn.getcwd(),
      program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
      args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
      autoAttachChildProcesses = true,
      smartStep = true,
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with deno)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
      runtimeExecutable = "deno",
      attachSimplePort = 9229,
    },
    {
      type = "pwa-chrome",
      request = "attach",
      name = "Attach Program (pwa-chrome, select port)",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      port = function()
        return vim.fn.input("Select port: ", 9222)
      end,
      webRoot = "${workspaceFolder}",
    },
    -- {
    --   type = "node2",
    --   request = "attach",
    --   name = "Attach Program (Node2)",
    --   processId = dap_utils.pick_process,
    -- },
    -- {
    --   type = "node2",
    --   request = "attach",
    --   name = "Attach Program (Node2 with ts-node)",
    --   cwd = vim.fn.getcwd(),
    --   sourceMaps = true,
    --   skipFiles = { "<node_internals>/**" },
    --   port = 9229,
    -- },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach Program (pwa-node, select pid)",
      cwd = vim.fn.getcwd(),
      processId = dap_utils.pick_process,
      skipFiles = { "<node_internals>/**" },
    },
  }
end
