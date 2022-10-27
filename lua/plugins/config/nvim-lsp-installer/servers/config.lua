local util = require 'util'

local M = {}

local ok, cmp = pcall(require, 'cmp_nvim_lsp')
if not ok then
    return
end

local w_ok, wk = pcall(require, 'which-key')
if not w_ok then
    return
end

M.capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

M.on_attach = function(client)
    wk.register {
        f = {
            name = '+diagnostics',
            ne = { vim.diagnostic.goto_next, 'go to next error' },
            pe = { vim.diagnostic.goto_prev, 'go to prev error' },
        },
        g = {
            name = '+jump',
            d = { vim.lsp.buf.definition, 'go to definition' },
            r = { vim.lsp.buf.references, 'go to references' },
        },
        K = { vim.lsp.buf.hover, 'hover' },
        qf = { vim.lsp.buf.code_action, 'quickfix / code action' },
        ['<leader>rn'] = { vim.lsp.buf.rename, 'rename' },
    }

    if client and client.server_capabilities.document_highlight then
        util.augroup('LspDocumentHighlight', {
            {
                events = { 'CursorHold' },
                targets = { '<buffer>' },
                command = vim.lsp.buf.document_highlight,
            },
            {
                events = { 'CursorHoldI' },
                targets = { '<buffer>' },
                command = 'silent! lua vim.lsp.buf.document_highlight()',
            },
            {
                events = { 'CursorMoved' },
                targets = { '<buffer>' },
                command = vim.lsp.buf.clear_references,
            },
        })
    end
    util.augroup('HoverDiagnostics', {
        {
            events = { 'CursorHold' },
            targets = { '<buffer>' },
            command = 'silent! lua vim.diagnostic.open_float({ focusable = false })',
        },
    })
end

return M
