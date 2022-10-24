local ok, cmp = pcall(require, 'cmp')
if not ok then
    return
end

local ok_snip, snip = pcall(require, 'luasnip')
if not ok_snip then
    return
end

cmp.setup {
    snippet = {
        expand = function(args)
            snip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = require('cmp').mapping.select_next_item(),
        ['<CR>'] = require('cmp').mapping.confirm { select = false },
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'neorg' },
    },
}
