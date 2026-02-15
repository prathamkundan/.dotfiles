-- LSP keybindings

local nvim = vim

nvim.api.nvim_create_autocmd('LspAttach', {
    group = nvim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            nvim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('gl', nvim.diagnostic.open_float, 'View Diagnostic')
        map('[d', nvim.diagnostic.goto_prev, 'Go to prev diagnostic')
        map(']d', nvim.diagnostic.goto_next, 'Go to next diagnostic')
        map('go', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>wd', require('telescope.builtin').diagnostics, '[W]orkspae [D]iagnostics')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<F2>', nvim.lsp.buf.rename, 'Rename')
        map('<F3>', nvim.lsp.buf.format, 'Format')
        map('<F4>', nvim.lsp.buf.code_action, '[C]ode [A]ction')
        map('gs', nvim.lsp.buf.signature_help, 'See [S]ignature')
        map('K', nvim.lsp.buf.hover, 'Hover Documentation')
        map('gD', nvim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = nvim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            nvim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                callback = nvim.lsp.buf.document_highlight,
            })

            nvim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                callback = nvim.lsp.buf.clear_references,
            })
        end
    end,
})

local capabilities = nvim.lsp.protocol.make_client_capabilities()
capabilities = nvim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local servers = {
    clangd = {},
    gopls = {},
    black = {},
    pyright = {
        settings = {
            pyright = { autoImportCompletion = true, },
            python = {
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = 'basic'
                }
            }
        }
    },
    rust_analyzer = {},
    lua_ls = {},
}

-- Mason

nvim.api.nvim_create_autocmd('FileType', {
    pattern = 'java',
    callback = function(args)
        require "custom.jdtls.setup_jdtls".setup()
    end
})

require('mason').setup()

local ensure_installed = nvim.tbl_keys(servers or {})
nvim.list_extend(ensure_installed, {
    'stylua', -- Used to format Lua code
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup {
    automatic_installation = {
        exclude = { "jdtls" }
    },
    handlers = {
        function(server_name)
            if server_name == 'jdtls' then
                return
            end

            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = nvim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
}
