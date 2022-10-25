local packages = require 'plugins.packages'

local function init(success)
    if not success then
        return
    end

    vim.cmd 'packadd packer.nvim'

    packages.setup()
end

(function()
    local packer = {
        path = vim.fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim',
        url = 'https://github.com/wbthomason/packer.nvim',
    }

    if vim.fn.executable 'git' ~= 1 then
        return
    end

    if vim.fn.empty(vim.fn.glob(packer.path)) > 0 then
        local handle
        handle = vim.loop.spawn(
            'git',
            {
                args = {
                    'clone',
                    packer.url,
                    packer.path,
                },
            },
            vim.schedule_wrap(function(code, _)
                handle:close()
                init(code == 0)
            end)
        )
    else
        init(true)
    end
end)()
