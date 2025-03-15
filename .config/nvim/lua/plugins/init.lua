local overrides = require "configs.overrides"

return {
    -- File browser
    {
        "nvim-tree/nvim-tree.lua",
        enabled = false,
    },

    {
        "mikavilpas/yazi.nvim",
    },

    -- Formatting
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = overrides.conform,
    },

    -- Binary manager
    {
        "williamboman/mason.nvim",
        opts = overrides.mason,
    },

    -- Syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },

    -- Lsp configuration
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    -- Completion engine
    {
        "hrsh7th/nvim-cmp",
        opts = overrides.cmp,
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        opts = { enable_autosnippets = true },
        -- config = function()
        -- require("custom.configs.luasnip")
        -- end,
    },

    -- Disable default snippets >:(
    {
        "rafamadriz/friendly-snippets",
        enabled = false,
    },

    -- LaTeX
    {
        "lervag/vimtex",
        ft = { "latex" },
        lazy = false, -- Lazy loading breaks the plugin
        config = function()
            require "configs.vimtex"
        end,
    },

    -- Markdown
    {
        "MeanderingProgrammer/render-markdown.nvim",
        cmd = { "RenderMarkdown" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("render-markdown").setup {
                file_types = { "markdown", "gitcommit" },
                html = { enabled = false },
                completions = { lsp = { enabled = true } },
                render_modes = true, -- Render in every mode
                code = { style = "language" },
            }
        end,
        opts = {},
    },

    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup { app = "brave", "--new-window" }
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
}
