local M = {}

function M.setup()
    local ok, ts = pcall(require, 'nvim-treesitter.configs')
    if not ok then
        return
    end

    ts.setup {
        ensure_installed = {
            'go',
            'gomod',
            'graphql',
            'json',
            'html',
            'lua',
            'prisma',
            'yaml',
            'rust',
            'cmake',
            'bash',
            'css',
            'dockerfile',
            'typescript',
            'tsx',
            'javascript',
            'norg',
        },
        highlight = {
            enable = true,
            use_languagetree = true,
        },
        autopairs = {
            enable = true,
        },
        context_commentstring = {
            enable = true,
        },
    }
end

return M
