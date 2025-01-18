local overrides = require("custom.configs.overrides")

local plugins = {

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
            require("plugins.configs.lspconfig")
            require("custom.configs.lspconfig")
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

    -- LSP diagnostics, code actions, formatting, ...
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        lazy = true,
        dependencies = {
            "nvimtools/none-ls-extras.nvim", -- For deprecated sources
        },
        ft = {
            "lua",
            "python",
            "rust",
        },
        opts = function()
            return require("custom.configs.null-ls")
        end,
    },

    -- Debugger
    {
        "mfussenegger/nvim-dap",
        config = function(_)
            require("core.utils").load_mappings("dap")
        end
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        opts = {
            handlers = {} -- Use default configs
        },
    },

    {
        "mfussenegger/nvim-dap-python",
        ft = { "python" },
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function(_)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end,
    },

    -- TODO Configure rustaceanvim
    -- Rust
    {
        "rust-lang/rust.vim",
        ft = { "rust" },
        init = function()
            vim.g.rustfmt_autosave = 1
        end
    },

    {
        "saecki/crates.nvim",
        ft = { "rust", "toml" },
        config = function(_, opts)
            local crates = require("crates")
            crates.setup(opts)
            crates.show()
        end
    },

    -- LaTeX
    {
        "lervag/vimtex",
        ft = { "latex" },
        lazy = false, -- Lazy loading breaks the plugin
        config = function()
            require("custom.configs.vimtex")
        end,
    },
}

return plugins
