local ok, neorg = pcall(require, 'neorg')
if not ok then
    return
end

neorg.setup {
    load = {
        ['core.defaults'] = {},
        ['core.norg.concealer'] = {
            preset = 'diamond',
            config = {
                preset = 'diamond',
            },
        },
        ['core.norg.completion'] = {
            config = {
                engine = 'nvim-cmp',
            },
        },
        ['core.norg.dirman'] = {
            config = {
                workspaces = {
                    work = '~/notes/work',
                    home = '~/notes/home',
                },
                autochdir = true,
                index = 'index.norg',
            },
        },
    },
}
