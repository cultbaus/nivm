local util = require 'util'

-- Normal mode
util.inoremap('jk', '<ESC>')

-- Terminal mode escapes
util.tnoremap('<ESC>', [[<C-\><C-n>]])
util.tnoremap('jk', [[<C-\><C-n>]])

-- Escape
util.nnoremap('q:', ':q')
