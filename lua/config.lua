-- Colors
vim.cmd 'filetype plugin indent on'
vim.cmd 'syntax on'

-- 200 WPM config
vim.cmd 'command! -nargs=* W w'
vim.cmd 'command! -nargs=* Wq wq'
vim.cmd 'command! -nargs=* Q q'

vim.diagnostic.config {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
}

O = {
    colorscheme = 'gruvbox',
    smart_close = 'help,startuptime,qf,lspinfo,packer,tsplayground',
}
