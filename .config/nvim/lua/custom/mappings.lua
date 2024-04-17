local M = {}

M.general = {
    n = {
        ["<leader>tt"] = {
            function()
                require("base46").toggle_transparency()
            end,
            "Toggle transparency",
        },
        ["<leader>L"] = { "<Cmd>lua require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/lua/custom/luasnip/'})<CR>", "Reload snippets" },
    },
}

M.telescope = {
    n = {
        ["<leader>gf"] = { ":Telescope git_files", "Git file search" },
        ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "Telescope bookmarks" },
    }
}

M.dap = {
    plugin = true,
    n = {
        ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Toggle breakpoint on current line" },
        ["<leader>dr"] = { "<cmd> DapContinue <CR>", "Start or continue debugger" },
        ["<leader>dpr"] = {
            function()
                require('dap-python').test_method()
            end,
            "Start or continue Python debugger",
        }
    }
}

M.crates = {
    n = {
        ["<leader>puc"] = {
            function()
                require("crates").upgrade_all_crates()
            end,
            "Update crates",
        },
    }
}

return M
