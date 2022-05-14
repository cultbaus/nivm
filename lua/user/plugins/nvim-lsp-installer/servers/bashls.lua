local M = {}

local ok, lsp = pcall(require, 'lspconfig')
if not ok then
    return
end

M.setup = function(lsp_opts)
    lsp.bashls.setup {
        capabilities = lsp_opts.capabilities,
        on_attach = function(client)
            lsp_opts.on_attach(client)
        end,
    }
end

return M
