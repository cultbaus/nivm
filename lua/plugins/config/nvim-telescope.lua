local util = require 'util'

local M = {}

local b_ok, b = pcall(require, 'telescope.builtin')
if not b_ok then
    return
end

local function find_files()
    if util.is_git_dir == 0 then
        b.git_files {}
    else
        b.find_files { previewer = false }
    end
end

local function live_grep()
    b.live_grep { previwer = false }
end

function M.setup()
    local ok, telescope = pcall(require, 'telescope')
    if not ok then
        return
    end

    local w_ok, wk = pcall(require, 'which-key')
    if not w_ok then
        return
    end

    wk.register {
        name = '+find',
        ['<C-p>'] = { find_files, 'find file' },
        ['<C-g>'] = { live_grep, 'live grep' },
    }

    local a_ok, a = pcall(require, 'telescope.actions')
    if not a_ok then
        return
    end

    telescope.setup {
        layout_strategy = 'horizontal',
        use_less = false,
        file_ignore_patterns = {
            '%.jpg',
            '%.jpeg',
            '%.png',
            '%.otf',
            '%.ttf',
            '%.sum',
            'node_modules',
            '.git',
        },
        mappings = {
            i = {
                ['<Esc>'] = a.close,
                ['<C-k>'] = a.move_selection_previous,
                ['<C-j>'] = a.move_selection_next,
            },
        },
    }
end

return M
