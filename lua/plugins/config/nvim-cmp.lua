local M = {}

function M.setup()
    local ok, cmp = pcall(require, 'cmp')
    if not ok then
        return
    end

    local ok, snip = pcall(require, 'luasnip')
    if not ok then
        return
    end

    cmp.setup {
        snippet = {
            expand = function(args)
                snip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<CR>'] = cmp.mapping.confirm { select = false },
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'neorg' },
        },
    }
end

return M
