local f_utils = require('flo.utils');

-- Getting codelldb to work with rust-analyzer
--
local extension_path = f_utils.concatToPath(
  f_utils.getHomeDirectory(),
  '.vscode',
  'extensions',
  'vadimcn.vscode-lldb-1.8.1'
);

local codelldb_path = f_utils.concatToPath(
  extension_path,
  'adapter',
  'codelldb'
);

local ext = ".so";
if f_utils.isWindows() then
  ext = ".lib";
end

local liblldb_path = f_utils.concatToPath(
  extension_path,
  "lldb",
  "lib",
  "liblldb" .. ext
);

print("codelldb_path: " .. codelldb_path);
print("liblldb_path: " .. liblldb_path);
