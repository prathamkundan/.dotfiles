local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
