
function getSeperator()
  local sep = package.config:sub(1,1);
  return sep;
end

function isWindows()
  local isWinSeperator = getSeperator() == "\\";
  local hasWin = vim.fn.has("win32") == 1;
  return isWinSeperator and hasWin;
end

function getHomeDirectory()
  local home = os.getenv("HOME");
  if isWindows() then
    home = os.getenv("USERPROFILE");
  end
  return home;
end

function concatToPath(...)
  local path = "";
  local args = {...};
  for i = 1, #args do
    -- concatenate the arguments as string to a new relative path with os 
    -- separator
    local sep = getSeperator();
    if i == #args then
      sep = "";
    end
    path = path .. args[i] .. sep;
  end
  return path;
end

function getPluginPath(plugin_name, opt)
  local plugin_path = "";
  local home = getHomeDirectory();
  local opt_or_start = "start";
  if opt then
    opt_or_start = "opt";
  end
  plugin_path = concatToPath(home, ".local", "share", "nvim", "site", "pack", "packer", opt_or_start, plugin_name);
  if isWindows() then
    plugin_path = concatToPath(home, "AppData", "Local", "nvim-data", "site", "pack", "packer", opt_or_start, plugin_name);
  end
  return plugin_path;
end

return {
  getSeperator = getSeperator,
  isWindows = isWindows,
  getHomeDirectory = getHomeDirectory,
  concatToPath = concatToPath,
  getPluginPath = getPluginPath
}

