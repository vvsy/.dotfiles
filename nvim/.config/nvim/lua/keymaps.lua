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
