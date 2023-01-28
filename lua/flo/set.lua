

-- Sets a ruler at 80 characters
vim.opt.colorcolumn = '80,100,120'

-- I want linenumbers
vim.opt.number = true;

-- I want indenting
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

-- vim.opt.undodir = "~/.vim/undodir"
-- vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.splitright = true

-- set file line endings to unix
-- vim.opt.fileformats = "unix"

-- set clipboard to use system clipboard
vim.opt.clipboard = "unnamedplus"

-- set the default file encoding to utf-8
vim.opt.encoding = "utf-8"
