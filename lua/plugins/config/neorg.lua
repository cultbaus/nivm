local M = {}

function M.setup()
    local neorg_ok, neorg = pcall(require, 'neorg')
    if not neorg_ok then
        return
    end

    local wk_ok, wk = pcall(require, 'which-key')
    if not wk_ok then
        return
    end

    neorg.setup {
        load = {
            ['core.defaults'] = {},
            ['core.norg.concealer'] = {
                preset = 'diamond',
                config = {
                    preset = 'basic',
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

    wk.register {
        ['<leader>'] = {
            name = '+norg',
            w = { '<cmd>Neorg workspace work<CR>', 'jump to workspace for work' },
            p = { '<cmd>Neorg workspace home<CR>', 'jump to workspace for personal' },
        },
    }
end

return M
