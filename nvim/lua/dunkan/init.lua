require("dunkan.remap")
require("dunkan.lazy")

local nvim = vim

nvim.opt.nu = true
nvim.opt.tabstop = 4
nvim.opt.shiftwidth = 4
nvim.opt.softtabstop = 4
nvim.opt.expandtab = true
nvim.opt.smartindent = true
nvim.opt.autoread = true

nvim.opt.list = true
nvim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

nvim.opt.hlsearch = false
nvim.opt.incsearch = true

nvim.opt.undofile = true
nvim.opt.swapfile = false
nvim.opt.backup = false

nvim.opt.termguicolors = true
nvim.opt.timeoutlen = 500
nvim.opt.ttimeoutlen = 250
nvim.opt.showmode = false

nvim.g.loaded_netrw = 1
nvim.g.loaded_netrwPlugin = 1
