vim.cmd("colorscheme gruvbox")

-- bufferline
vim.opt.termguicolors = true
require("bufferline").setup{}

-- diagnostic
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        show_header = true,
        source = "always",
        border = "rounded",
    },
})
