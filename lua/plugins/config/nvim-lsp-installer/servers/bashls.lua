local M = {}

local ok, lsp = pcall(require, 'lspconfig')
if not ok then
    return
end

function M.setup(config)
    lsp.bashls.setup {
        capabilities = config.capabilities,
        on_attach = function(client)
            config.on_attach(client)
        end,
    }
end

return M
