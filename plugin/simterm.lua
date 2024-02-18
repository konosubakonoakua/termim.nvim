if vim.g.loaded_simterm then
    return
end

vim.g.loaded_simterm = true

vim.api.nvim_create_autocmd({ 'TermClose' }, {
    group = vim.api.nvim_create_augroup('simterm_auto_close', { clear = true }),
    callback = function()
        vim.cmd('quit')
    end,
})

vim.api.nvim_create_autocmd({ 'TermOpen' }, {
    group = vim.api.nvim_create_augroup('simterm_open', { clear = true }),
    callback = function(event)
        vim.cmd('setlocal nonumber')
        vim.cmd('setlocal norelativenumber')
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
})

vim.api.nvim_create_user_command('Term', function(input)
    require("simterm").open(input.args)
end, { nargs = '*' })

vim.api.nvim_create_user_command('Sterm', function(input)
    require("simterm").open(input.args, 'split')
end, { nargs = '*' })

vim.api.nvim_create_user_command('Vterm', function(input)
    require("simterm").open(input.args, 'vsplit')
end, { nargs = '*' })

vim.keymap.set('t', 'JJ', '<C-\\><C-n>', { buffer = true })