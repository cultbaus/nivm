local M = {}

local ok, lsp = pcall(require, 'lspconfig')
if not ok then
    return
end

M.setup = function(config)
    lsp.tsserver.setup {
        capabilities = config.capabilities,
        on_attach = function(client)
            if client.config.flags then
                client.config.flags.allow_incremental_sync = true
            end

            config.on_attach(client)
        end,
    }
end

return M
