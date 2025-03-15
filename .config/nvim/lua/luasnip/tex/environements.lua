local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

-- Math context detection
local tex = {}
tex.in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
    return not tex.in_mathzone()
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return {
    -- EQUATION
    s(
        { trig = "nn", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{equation*}
            <>
        \end{equation*}
      ]],
            {
                i(1),
            }
        ),
        { condition = line_begin }
    ),
    -- ALIGN
    s(
        { trig = "all", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{align*}
            <>
        \end{align*}
      ]],
            {
                i(1),
            }
        ),
        { condition = line_begin }
    ),
    -- ITEMIZE
    s(
        { trig = "itt", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{itemize}

            \item <>

        \end{itemize}
      ]],
            {
                i(0),
            }
        ),
        { condition = line_begin }
    ),
    -- ENUMERATE
    s(
        { trig = "enn", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{enumerate}

            \item <>

        \end{enumerate}
      ]],
            {
                i(0),
            }
        )
    ),
}
