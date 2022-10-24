local M = {}

local ok, lsp = pcall(require, 'lspconfig')
if not ok then
    return
end

M.setup = function(config)
    lsp.gopls.setup {
        on_attach = function(client, bufnr)
            config.on_attach(client, bufnr)
            vim.o.list = false
        end,
        cmd = { 'gopls', 'serve' },
        settings = {
            gopls = {
                analyses = {
                    unreachable = true,
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    }
end

return M
