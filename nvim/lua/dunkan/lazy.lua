local nvim = vim

local lazypath = nvim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not nvim.loop.fs_stat(lazypath) then
    nvim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
nvim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "bluz71/vim-moonfly-colors",       name = "moonfly",   lazy = false, priority = 1000 },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            -- used for completion, annotations and signatures of Neovim apis
            { 'folke/neodev.nvim', opts = {} },
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
    },
    -- { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-path' },
    { 'L3MON4D3/LuaSnip' },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'tpope/vim-fugitive' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        opts = {}
    },
    { 'mfussenegger/nvim-jdtls' }
}
local opts = {}

require("lazy").setup(plugins, opts)
