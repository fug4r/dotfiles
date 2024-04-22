local null_ls = require("null-ls")

local opts = {
    sources = {
        -- Python
        -- null_ls.builtins.diagnostics.mypy,

        -- C/C++
        -- null_ls.builtins.formatting.clang_format, -- Clangd LSP has native support
    },
}

return opts
