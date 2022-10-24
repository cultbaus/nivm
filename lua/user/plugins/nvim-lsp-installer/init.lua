local ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not ok then
    return
end

local ensure_installed = {
    'gopls',
    'sumneko_lua',
    'rust_analyzer',
    'tsserver',
    'bashls',
    'cmake',
    'pyright',
}

lsp_installer.setup {
    ensure_installed = ensure_installed,
    automatic_installation = true,
}

local path = (...):gsub('%.init%', '')
local servers = path .. '.servers.'
local config = require(path .. '.config')

for _, server in pairs(ensure_installed) do
    local module_found, module = pcall(require, servers .. server)
    if module_found then
        module.setup(config)
    end
end
