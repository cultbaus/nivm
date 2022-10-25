local M = {}

function M.setup()
    local ok, ap = pcall(require, 'nvim-autopairs')
    if not ok then
        return
    end

    local ok, cmp = pcall(require, 'cmp')
    if not ok then
        return
    end

    ap.setup {}
    cmp.setup {
        map_complete = false,
        map_cr = true,
        auto_select = true,
    }
end

return M
