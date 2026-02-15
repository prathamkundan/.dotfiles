function Color(scheme)
    scheme = scheme or "moonfly"
    vim.cmd.colorscheme(scheme)
    vim.g.moonflyTransparent = true
    vim.g.moonflyCursorColor = true
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
end

Color()
