local ok, null_ls = pcall(require, 'null-ls')
if not ok then
    return
end

vim.diagnostic.config {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
}

-- Requires nvim 0.8+
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

-- Requires nvim 0.8+
local augroup = vim.api.nvim_create_augroup('Format', {})

-- Requires nvim 0.8+
local on_attach = function(client, bufnr)
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

-- Null is a standalone server, so it needs it's own special config
null_ls.setup {
    on_attach = on_attach,
    diagnostics_format = '[#{c}] #{m} (#{s})',
    sources = {
        null_ls.builtins.formatting.prettierd.with {
            filetypes = { 'html', 'json', 'markdown' },
        },
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt.with {
            args = { '-i', '2', '-ci' },
        },
        null_ls.builtins.formatting.autopep8,
    },
}
