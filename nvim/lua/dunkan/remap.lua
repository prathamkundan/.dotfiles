local opts = { noremap = true, silent = true }
local nvim = vim

nvim.g.mapleader = " "
nvim.keymap.set('n', "<C-b>", ":NvimTreeToggle <CR>", opts)

-- Move lines
nvim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
nvim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)

-- Exit in terminal
nvim.keymap.set("t", '\\\\', '<C-\\><C-n>', { noremap = true, silent = true })

-- Yank and Pasting
nvim.keymap.set({"v", "n"}, "<leader>y", "\"+y", opts)
nvim.keymap.set({"v", "n"}, "<leader>p", "\"+p", opts)
nvim.keymap.set({"v", "n"}, "<leader>P", "\"+P", opts)
nvim.keymap.set("v", 'p', "\"_dP", opts)

-- Some insert mode conveniences
nvim.keymap.set({"i", "v"}, "kj", "<Esc>", opts)

-- windows
nvim.keymap.set("n", "<leader>wj", "<C-w>j", opts)
nvim.keymap.set("n", "<leader>wl", "<C-w>l", opts)
nvim.keymap.set("n", "<leader>wk", "<C-w>k", opts)
nvim.keymap.set("n", "<leader>wh", "<C-w>h", opts)
-- Resisizing windows
nvim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
nvim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)
nvim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
nvim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)

-- scrolling
nvim.keymap.set('n', '<C-j>', '2j<C-e><C-e>', opts)
nvim.keymap.set('n', '<C-k>', '2k<C-y><C-y>', opts)

-- tpope unimpared but for me
nvim.keymap.set('n', ']<leader>', 'o<Esc>k', opts);
nvim.keymap.set('n', ']b', ':bnext<CR>', opts);
nvim.keymap.set('n', '[b', ':bprevious<CR>', opts);
nvim.keymap.set('n', ']T', ':tablast<CR>', opts);
nvim.keymap.set('n', ']t', ':tabnext<CR>', opts);
nvim.keymap.set('n', '[t', ':tabprevious<CR>', opts);
nvim.keymap.set('n', '[T', ':tabfirst<CR>', opts);
