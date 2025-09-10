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

    -- lsp related
	{
		'williamboman/mason.nvim',  -- Management of LSP
		config = function()
		    require("mason").setup({})
        end,
	},

    -- linter
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

    -- auto completion
    {
        "hrsh7th/nvim-cmp",
	  	-- event = 'InsertEnter',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},  -- Required for LSP integration
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        -- Use native neovim snippets (Neovim 0.10+)
                        vim.snippet.expand(args.body)
                    end,
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
                    }, {
                        { name = 'buffer' },
                }),
            })

            -- NATIVE LSP CONFIG (Neovim 0.11+)
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Python LSP (pyright)
            vim.lsp.config.pyright = {
                cmd = {'pyright-langserver', '--stdio'},
                filetypes = {'python'},
                root_markers = {'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git'},
                capabilities = capabilities,
                handlers = {
                    ["textDocument/publishDiagnostics"] = function()
                        -- Disable pyright diagnostics, let pylint handle linting
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

            -- Enable only pyright LSP server
            vim.lsp.enable({'pyright'})

        end
    },

    -- preview .md
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


