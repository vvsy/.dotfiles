-- Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local _, wf = pcall(require, "vim.lsp._watchfiles")
wf._watchfunc = function()
    return function() end
end

-- Plugins Setting
require("lazy").setup({

    -- color scheme
	{
        "zenbones-theme/zenbones.nvim",
		dependencies = { 'rktjmp/lush.nvim' },

	},

    -- fuzzy finder
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

    -- file tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
        -- dependencies = 'nvim-tree/nvim-web-devicons'
		lazy = false,
		config = function()
			require("nvim-tree").setup {
                renderer = {
                    icons = {
                        show = {
                            file = false,
                            folder = false,
                        }
                    }
                }
            }
		end,

	},

    -- buffer above
	{
		'akinsho/bufferline.nvim',
        version = "*",
        -- dependencies = 'nvim-tree/nvim-web-devicons'
	},

    -- quick comment
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup({ create_mappings = false })
		end,
	},

    -- lsp
	{
		'williamboman/mason.nvim',
		config = function()
		    require("mason").setup({})
        end,
	},
	{
	    'neovim/nvim-lspconfig',
	  	cmd = {'LspInfo', 'LspInstall', 'LspStart'},
	  	event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
	  	    {'hrsh7th/cmp-nvim-lsp'},
        },
	    config = function()
            -- Required lsp in "nvim-cmp"
	    end,
	},
	{
	    "mfussenegger/nvim-lint",
	    event = { "BufReadPre", "BufNewFile" },
	    config = function()
            require("lint").linters_by_ft = {
                python = { "pylint" },
            }
	        vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
	            group = _G.group,
	            callback = function()
	                require("lint").try_lint()
	            end,
	        })
	    end,
	},
    {
        "hrsh7th/nvim-cmp",
	  	-- event = 'InsertEnter',
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                    }, {
                        { name = 'buffer' },
                }),
            })
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            require('lspconfig').pyright.setup {
                capabilities = capabilities,
                handlers = {
                    ["textDocument/publishDiagnostics"] = function()
                    end
                },
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = 'openFilesOnly',
                        },
                    },
                },
            }
            require("lspconfig").lua_ls.setup({
                capabilities = capabilities
            })
            -- require("prettier").lua_ls.setup({
            --     capabilities = capabilities,
            --     bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
            --     filetypes = {
            --         "css",
            --         "graphql",
            --         "html",
            --         "javascript",
            --         "javascriptreact",
            --         "json",
            --         "less",
            --         "markdown",
            --         "scss",
            --         "typescript",
            --         "typescriptreact",
            --         "yaml",
            --     },
            -- })

        end
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_port = '8894'
            vim.g.mkdp_echo_preview_url = 1
        end,
        ft = { "markdown" },
    },
})


