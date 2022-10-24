local M = {}

local ok, lsp = pcall(require, 'lspconfig')
if not ok then
    return
end

M.setup = function(lsp_opts)
    lsp.sumneko_lua.setup {
        capabilities = lsp_opts.capabilities,

        on_attach = function(client)
            lsp_opts.on_attach(client)
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
