local M = {}

function M.setup(config)
    local ok, lspconfig = pcall(require, 'lspconfig')
    if not ok then
        return
    end

    lspconfig.gopls.setup {
        on_attach = function(client, bufnr)
            vim.o.list = false
            config.on_attach(client, bufnr)
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
