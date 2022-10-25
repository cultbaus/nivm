local M = {}

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format {
        filter = function(clients)
            return vim.tbl_filter(function(client)
                return client == 'null-ls'
            end, clients)
        end,
        bufnr = bufnr,
    }
end

local augroup = vim.api.nvim_create_augroup('Format', {})

local function on_attach(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

function M.setup()
    local ok, null = pcall(require, 'null-ls')
    if not ok then
        return
    end

    null.setup {
        on_attach = on_attach,
        diagnostics_format = '[#{c}] #{m} (#{s})',
        sources = {
            null.builtins.formatting.prettierd.with {
                filetypes = { 'html', 'json', 'markdown' },
            },
            null.builtins.formatting.eslint_d,
            null.builtins.diagnostics.eslint_d,
            null.builtins.formatting.clang_format,
            null.builtins.formatting.goimports,
            null.builtins.formatting.gofmt,
            null.builtins.formatting.rustfmt,
            null.builtins.formatting.stylua,
            null.builtins.formatting.shfmt.with {
                args = { '-i', '2', '-ci' },
            },
            null.builtins.formatting.autopep8,
        },
    }
end

return M
