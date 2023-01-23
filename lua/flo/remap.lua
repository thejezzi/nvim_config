vim.g.mapleader = ' '
local set = vim.keymap.set;
-- open netwr up again (comes from the primeagen, gonna remove soon, what an idiot)
-- set("n", "<leader>fv", vim.cmd.Ex)

-- Set Control-S to save a file because vim kids are to cool to use standards
-- What a horrible editor and this is better because vscode takes to long?!
set("n", "<C-s>", ":w<CR>")
set("i", "<C-s>", "<Esc>:w<CR>")

-- set Control-A to select everything in the file
set("n", "<C-a>", "ggVG");

-- Set a keymap to close a buffer easily
set("n", "<leader>w", ":bd<CR>");

-- Leader-Key 't' -> ToggleTerm
--
set("n", "<leader>tt", ":ToggleTerm<CR>");

-- Neotree
--
set("n", "<leader>ns", ":NeoTreeShowToggle<CR>")
set("n", "<leader>nf", ":Neotree float<CR>")
set("n", "<leader>ng", ":Neotree float git_base<CR>")
set("n", "<leader>nb", ":Neotree float buffers<CR>")

-- Move line up or down with a simple keybinding
set("n", "K", ":m .-2<CR>==");
set("n", "J", ":m .+1<CR>==");
set("v", "K", ":m .-2<CR>gv=gv");
set("v", "J", ":m'>+<CR>gv=gv");

vim.api.nvim_buf_set_keymap(0, "v", "<leader>\"", [[c"<c-r>"<Esc>]], { noremap = false })
vim.api.nvim_buf_set_keymap(0, "v", "<leader><", [[c<<c-r>"><Esc>]], { noremap = false })
vim.api.nvim_buf_set_keymap(0, "v", "<leader>'", [[c'<c-r>"<Esc>]], { noremap = false })

