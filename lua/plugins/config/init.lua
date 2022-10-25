local function setup(plugin)
    require('plugins.config.' .. plugin).setup()
end

setup 'comment'
setup 'nvim-autopairs'
setup 'nvim-cmp'
setup 'nvim-lsp-installer'
setup 'nvim-telescope'
setup 'nvim-treesitter'
setup 'null-ls'
