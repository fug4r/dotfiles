require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Toggle transparency
map("n", "<leader>tt", "<cmd>lua require('base46').toggle_transparency()<CR>", { desc = "Toggle transparency" })

-- Remove NvimTree and replace it with yazi
nomap("n", "<C-n>")
map("n", "<leader>e", "<cmd>Yazi<CR>", { desc = "Yazi" })
map("n", "<leader>E", "<cmd>Yazi cwd<CR>", { desc = "Yazi cwd" })

-- Remove Tabufline keymaps
nomap("n", "<leader>b")
nomap("n", "<tab>")
nomap("n", "<S-tab>")
nomap("n", "<leader>x")

-- Markdown keybindings
map("n", "<leader>ms", "<cmd>RenderMarkdown<CR>", { desc = "Start markdown render" })
map("n", "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown render" })

map("n", "<leader>ps", "<cmd>PeekOpen<CR>", { desc = "Open markdown preview" })
map("n", "<leader>px", "<cmd>PeekClose<CR>", { desc = "Close markdown preview" })
