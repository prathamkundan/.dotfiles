local vimrc = vim.fn.expand("~/.vimrc")
if vim.fn.filereadable(vimrc) == 1 then
	vim.cmd("source " .. vim.fn.fnameescape(vimrc))
end

require("dunkan.remap")
require("dunkan.lazy")

-- Neovim-specific (shared opts and keymaps live in ~/.vimrc)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
