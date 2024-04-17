local M = {}

-- UI
M.ui = {
    theme = "chadracula",
    transparency = true,
    nvdash = {
        load_on_startup = true,
    },
}

-- Plugins
M.plugins = "custom.plugins"

-- Remaps
M.mappings = require("custom.mappings")

return M
