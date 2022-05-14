local M = {}

M.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


M.on_attach = function(client)
    client.server_capabilities.document_highlighting = false
    vim.cmd [[
        augroup HoverDiagnostics
            au!
            au CursorHold <buffer> lua vim.diagnostic.open_float({ focusable = false })
        augroup END
    ]]
end

return M
