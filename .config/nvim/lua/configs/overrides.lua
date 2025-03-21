local M = {}

M.treesitter = {
    --auto_install = true,

    ensure_installed = {
        -- Defaults
        "vim",
        "lua",

        -- Web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",

        -- General programming languages
        "c",
        "cpp",
        "rust",
        "python",

        -- Typesetting and markup
        --"latex", -- Causes problems with vimtex
        "markdown",
        "markdown_inline",

        -- Other/Esoteric
        "bash",
        "hyprlang",
        "asm",
    },

    highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = { "latex", "markdown" },
    },
}

M.mason = {
    ensure_installed = {
        -- Lua
        -- "lua-language-server", -- Already present in default config

        -- Python
        "pyright",
        "ruff",
        "mypy",
        "debugpy",

        -- Rust
        "rust-analyzer",

        -- C/C++
        "clangd",
        "codelldb",

        -- LaTeX
        "texlab",
    },
}

M.conform = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- css = { "prettier" },
        -- html = { "prettier" },
    },
    -- Set default options
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
    },
}

-- Nvim completions
local cmp = require "cmp"
M.cmp = {
    sources = {
        -- { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "crates" },
        { name = "render-markdown" },

        {
            name = "nvim_lsp",
            entry_filter = function(entry)
                if entry:get_kind() == 15 then
                    return false -- Disable LSP Snippets
                elseif entry:get_kind() == 1 then
                    return false -- Disable Text completions
                else
                    return true
                end
            end,
        },
    },

    mapping = {
        ["<CR>"] = cmp.config.disable,
        ["<C-e>"] = cmp.config.disable,

        -- Toggle completion
        ["<C-Space>"] = cmp.mapping {
            i = function()
                if cmp.visible() then
                    cmp.abort()
                else
                    cmp.complete()
                end
            end,
            c = function()
                if cmp.visible() then
                    cmp.close()
                else
                    cmp.complete()
                end
            end,
        },

        -- Super Tab
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm { select = true }
            elseif require("luasnip").expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if require("luasnip").jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
}

return M
