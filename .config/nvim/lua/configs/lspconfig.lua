local config = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

config.defaults() -- Loads NvChad's defaults

-- On attach and capabilities
    local capabilities = config.capabilities
local on_attach = function(client, bufnr)
    if client == "ruff" then
        lspconfig.ruff.server_capabilities.hoverProvider = false
    elseif client == "clangd" then
        client.server_capabilities.signatureHelpProvider = false
    end
    config.on_attach(client, bufnr)
end

-- Lua
lspconfig.lua_ls.setup {
    filetypes = { "lua" },
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
}

-- Python
lspconfig.pyright.setup {
    filetypes = { "python" },
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Ignoring all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
                -- Can also use Mypy for static type checking, and turn this option off
                typeCheckingMode = "off",
            },
        },
    },
}

lspconfig.ruff.setup {
    filetypes = { "python" },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Rust
lspconfig.rust_analyzer.setup {
    filetypes = { "rust" },
    on_attach = on_attach,
    capabilities = capabilities,

    root_dir = util.root_pattern "Cargo.toml",
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
        },
    },
}

-- C/C++
lspconfig.clangd.setup {
    filetypes = { "c", "cpp" },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- LaTeX
lspconfig.texlab.setup {
    filetypes = { "latex" },
    on_attach = on_attach,
    capabilities = capabilities,
}
