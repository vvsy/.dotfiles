require("keymaps")
require("options")
require("plugins.lazy")
require("plugins.keymaps")
require("plugins.options")

-- remove all trailing whitespace
vim.keymap.set('n', '<leader>tW', ':%s/\\s\\+$//e<CR>', { silent = true })

