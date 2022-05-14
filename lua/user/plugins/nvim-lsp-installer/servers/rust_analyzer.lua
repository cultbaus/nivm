local M = {}

local ok, lsp = pcall(require, 'lspconfig')
if not ok then
    return
end

M.setup = function(lsp_opts)
    lsp.rust_analyzer.setup {
        capabilities = lsp_opts.capabilities,
        on_attach = function(client)
            lsp_opts.on_attach(client)
        end,
        settings = {
            ['rust-analyzer'] = {
                assist = {
                    importMergeBehavior = 'last',
                    importPrefix = 'by_self',
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                procMacro = {
                    enable = true,
                },
            },
        },
    }
end

return M
