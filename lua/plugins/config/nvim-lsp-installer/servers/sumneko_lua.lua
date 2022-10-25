local M = {}

function M.setup(config)
    local ok, lsp = pcall(require, 'lspconfig')
    if not ok then
        return
    end

    lsp.sumneko_lua.setup {
        capabilities = config.capabilities,
        on_attach = function(client, bufnr)
            config.on_attach(client, bufnr)
        end,
        root_dir = require('lspconfig').util.root_pattern '.git/',
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = {
                        [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                        [vim.fn.stdpath 'config' .. '/lua'] = true,
                    },
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    }
end

return M
