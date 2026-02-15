
local builtin = require('telescope.builtin')
local nvim = vim

nvim.keymap.set('n', '<leader>T', builtin.builtin, {})
-- nvim.keymap.set('n', '<C-p>', builtin.git_files, {})
nvim.keymap.set('n', '<C-p>', function() builtin.find_files({ no_ignore = false, }) end, {})
nvim.keymap.set('n', '<leader>f', function() builtin.find_files({ no_ignore = true, }) end, {})
nvim.keymap.set('n', '<leader>fo', builtin.buffers, {})
nvim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
nvim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
