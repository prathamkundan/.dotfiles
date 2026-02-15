local M = {}

function M:setup()
    local home = os.getenv 'HOME'

    local os_name

    local uname = vim.loop.os_uname().sysname
    if uname == "Linux" then
        os_name = "linux"
    elseif uname == "Darwin" then
        os_name = "mac"
    elseif uname:match("Windows") then
        os_name = "win32"
    else
        os_name = "unknown"
    end

    local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
    if os_name == 'win32' then
        workspace_path = home .. '/AppData/Local/nvim-data/jdtls-workspace/'
    end

    local mason_path = home .. '/.local/share/nvim/mason/'
    if os_name == 'win32' then
        mason_path = home .. '/AppData/Local/nvim-data/mason/'
    end

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local workspace_dir = workspace_path .. project_name

    local status, jdtls = pcall(require, 'jdtls')
    if not status then
        return
    end
    local extendedClientCapabilities = jdtls.extendedClientCapabilities

    local config = {
        cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xmx1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens',
            'java.base/java.util=ALL-UNNAMED',
            '--add-opens',
            'java.base/java.lang=ALL-UNNAMED',
            '-javaagent:' .. mason_path .. 'packages/jdtls/lombok.jar',
            '-jar',
            vim.fn.glob(mason_path .. 'packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
            '-configuration', mason_path .. 'packages/jdtls/config_' .. os_name,
            '-data',
            workspace_dir,
        },

        root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew' },

        settings = {
            java = {
                autobuild = { enabled = false },
                signatureHelp = { enabled = true },
                extendedClientCapabilities = extendedClientCapabilities,
                maven = {
                    downloadSources = true,
                },
                referencesCodeLens = {
                    enabled = true,
                },
                references = {
                    includeDecompiledSources = true,
                },
                inlayHints = {
                    parameterNames = {
                        enabled = 'all', -- literals, all, none
                    },
                },
                format = {
                    enabled = true,
                },
            },
        },

        init_options = {
            bundles = {},
        },
    }

    require('jdtls').start_or_attach(config)
end

return M
