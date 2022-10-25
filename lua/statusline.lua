local util = require 'util'

local fn = vim.fn
local api = vim.api

local modes = {
    ['n'] = 'NORMAL',
    ['no'] = 'NORMAL',
    ['v'] = 'VISUAL',
    ['V'] = 'VISUAL LINE',
    [''] = 'VISUAL BLOCK',
    ['s'] = 'SELECT',
    ['S'] = 'SELECT LINE',
    [''] = 'SELECT BLOCK',
    ['i'] = 'INSERT',
    ['ic'] = 'INSERT',
    ['R'] = 'REPLACE',
    ['Rv'] = 'VISUAL REPLACE',
    ['c'] = 'COMMAND',
    ['cv'] = 'VIM EX',
    ['ce'] = 'EX',
    ['r'] = 'PROMPT',
    ['rm'] = 'MOAR',
    ['r?'] = 'CONFIRM',
    ['!'] = 'SHELL',
    ['t'] = 'TERMINAL',
}

local function mode()
    local current_mode = api.nvim_get_mode().mode
    return string.format(' %s ', modes[current_mode]):upper()
end

local function update_mode_colors()
    local current_mode = api.nvim_get_mode().mode
    local mode_color = '%#StatusLineAccent#'
    if current_mode == 'n' then
        mode_color = '%#StatuslineAccent#'
    elseif current_mode == 'i' or current_mode == 'ic' then
        mode_color = '%#StatuslineInsertAccent#'
    elseif current_mode == 'v' or current_mode == 'V' or current_mode == '' then
        mode_color = '%#StatuslineVisualAccent#'
    elseif current_mode == 'R' then
        mode_color = '%#StatuslineReplaceAccent#'
    elseif current_mode == 'c' then
        mode_color = '%#StatuslineCmdLineAccent#'
    elseif current_mode == 't' then
        mode_color = '%#StatuslineTerminalAccent#'
    end
    return mode_color
end

local function filepath()
    local fpath = fn.fnamemodify(fn.expand '%', ':~:.:h')
    if fpath == '' or fpath == '.' then
        return ' '
    end
    return string.format(' %%<%s/', fpath)
end

local function filename()
    local fname = fn.expand '%:t'
    if fname == '' then
        return ''
    end
    return fname .. ' '
end

local function filetype()
    return string.format(' %s ', vim.bo.filetype):upper()
end

local function lineinfo()
    if vim.bo.filetype == 'alpha' then
        return ''
    end
    return ' %P %#Normal# %l:%c '
end

local function lsp()
    -- TODO @gebhartn: Add lsp error/warn/hint counts + symbols
    return ''
end

Statusline = {}

Statusline.active = function()
    return table.concat {
        '%#Statusline#',
        update_mode_colors(),
        mode(),
        '%#Normal#',
        lsp(),
        '%=%#StatusLineExtra#',
        filetype(),
        lineinfo(),
    }
end

function Statusline.inactive()
    return ' %F'
end

util.augroup('Statusline', {
    {
        events = { 'WinEnter', 'BufEnter' },
        targets = { '*' },
        command = 'setlocal statusline=%!v:lua.Statusline.active()',
    },
    {
        events = { 'WinLeave', 'BufLeave' },
        targets = { '*' },
        command = 'setlocal statusline=%!v:lua.Statusline.inactive()',
    },
})
