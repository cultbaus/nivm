local path = (...):gsub('%.init%', '')

local M = {}

function M.setup()
    -- Lspconfig servers
    local configured_servers = { 'gopls', 'sumneko_lua', 'bashls', 'tsserver' }

    -- Shared configuration
    local config = require(path .. '.config')

    for _, module in pairs(configured_servers) do
        local ok, server = pcall(require, path .. '.' .. module)
        if ok then
            server.setup(config)
        end
    end
end

return M
