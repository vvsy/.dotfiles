-- Custom commands

-- Convenient command to see the difference between the current buffer and the
-- file it was loaded from, thus the changes you made.
-- Only define it when not defined already.
-- Revert with: ":delcommand DiffOrig".
vim.cmd([[
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
            \ | wincmd p | diffthis
  endif
]])

-- Git diff for current file
vim.api.nvim_create_user_command('Gd', function()
    vim.cmd('!git diff %')
end, { desc = 'Git diff current file' })
