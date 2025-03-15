require "nvchad.options"

local opt = vim.opt

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

-- Disable nbackups
opt.swapfile = false
opt.backup = false

-- Fixes search highlighting
opt.hlsearch = false
opt.incsearch = true

-- Set scrolloff
opt.scrolloff = 12

-- Load snippets from ~/.config/nvim/lua/luasnip/
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/luasnip"

-- Add hyprlang filetype
vim.filetype.add {
    pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
}
