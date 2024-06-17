vim.keymap.set('n', '<leader>ff', ":Telescope find_files<cr>")
vim.keymap.set('n', '<leader>fg', ":Telescope live_grep<cr>")
vim.keymap.set('n', '<leader>fb', ":Telescope buffers<cr>")
vim.keymap.set('n', '<leader>fh', ":Telescope help_tags<cr>")

vim.keymap.set('n', '<leader>d', ":NvimTreeFindFileToggle<cr>")

vim.keymap.set({'n', 'v'}, '<leader>/', ":CommentToggle<cr>")

-- Lint
vim.keymap.set("n", "<leader>l", function() require("lint").try_lint() end)
-- Disable virtual text for diagnostics
vim.keymap.set("n", "<leader>ll", function()
    local current_virtual_text = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({
        virtual_text = not current_virtual_text,
    })
end
)

-- vim.keymap.set('n', '<leader>mp', ":MarldownPreviewToggle<cr>")
