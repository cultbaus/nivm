local M = {}

function M.setup()
    local ok, packer = pcall(require, 'packer')
    if not ok then
        return
    end

    packer.startup {
        function(use)
            use 'sainnhe/gruvbox-material'
            use 'nvim-treesitter/nvim-treesitter'
            use 'neovim/nvim-lspconfig'
            use 'windwp/nvim-autopairs'
            use 'hrsh7th/nvim-cmp'
            use 'hrsh7th/cmp-nvim-lsp'
            use 'hrsh7th/cmp-buffer'
            use 'L3MON4D3/LuaSnip'
            use 'JoosepAlviste/nvim-ts-context-commentstring'
            use 'numToStr/Comment.nvim'
            use 'williamboman/nvim-lsp-installer'
            use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
            use {
                'jose-elias-alvarez/null-ls.nvim',
                requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
            }
            use 'folke/which-key.nvim'
            packer.install()
        end,
    }

    local c_ok, p = pcall(require, 'plugins.config')
    if not c_ok then
        return
    end

    if type(p) == 'boolean' then
        return
    end
end

return M
