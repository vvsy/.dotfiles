-- spacebar as leader key
vim.g.mapleader = " "

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>p", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")

-- go-to def
vim.keymap.set("n", '<leader>q', ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<leader>q|', ':vsplit | lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<leader>q-', ':belowright split | lua vim.lsp.buf.definition()<CR>')

-- Expand pane horizontally
vim.keymap.set('n', '<leader><leader>', ':vertical resize +4<CR>', { noremap = true, silent = true })

-- remove all trailing whitespace
vim.keymap.set('n', '<leader>tW', ':%s/\\s\\+$//e<CR>', { silent = true })

-- gitsigns
vim.keymap.set('n', ']c', ':Gitsigns next_hunk<CR>', { silent = true })
vim.keymap.set('n', '[c', ':Gitsigns prev_hunk<CR>', { silent = true })
vim.keymap.set('n', '<leader>gh', ':Gitsigns preview_hunk<CR>', { silent = true })
vim.keymap.set('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', { silent = true })

-- Rotate pane
vim.keymap.set('n', '<leader>wr', '<C-w>r', { desc = 'Rotate panels right' })
vim.keymap.set('n', '<leader>wR', '<C-w>R', { desc = 'Rotate panels left' })
vim.keymap.set('n', '<leader>wx', '<C-w>x', { desc = 'Exchange panels' })

