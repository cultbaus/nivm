local M = {}

function M.setup()
    local ok, comment = pcall(require, 'Comment')
    if not ok then
        return
    end

    comment.setup {
        padding = true,
        mappings = {
            basic = true,
            extra = true,
        },
    }
end

return M
