local nvim = vim
require('nvim-treesitter').setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "vimdoc", "bash", "python" },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    highlight = {
        enable = true,
    },
}

nvim.api.nvim_create_autocmd('FileType', {
  callback = function()
    nvim.wo.foldmethod = 'expr'
    nvim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    nvim.wo.foldlevel = 99
  end,
})

if nvim.loop.os_uname().sysname:match("Windows") then
    require('nvim-treesitter.install').compilers = { "gcc", "clang" }
end
