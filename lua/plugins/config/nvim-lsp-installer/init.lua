local M = {}

local servers = require 'plugins.config.nvim-lsp-installer.servers'

function M.setup()
    local ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
    if not ok then
        return
    end

    lsp_installer.setup {
        automatic_installation = true,
    }

    servers.setup()
end

return M
