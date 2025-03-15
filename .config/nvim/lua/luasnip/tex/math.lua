local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

-- Math context detection
local tex = {}
tex.in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
    return not tex.in_mathzone()
end

-- Return snippet tables
return {
    -- ZERO SUBSCRIPT SHORTCUT
    s(
        { trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t "0",
        }),
        { condition = tex.in_mathzone }
    ),
    -- MINUS ONE SUPERSCRIPT SHORTCUT
    s(
        { trig = "([%a%)%]%}])11", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t "-1",
        }),
        { condition = tex.in_mathzone }
    ),
    -- J SUBSCRIPT SHORTCUT (since jk triggers snippet jump forward)
    s(
        { trig = "([%a%)%]%}])JJ", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t "j",
        }),
        { condition = tex.in_mathzone }
    ),
    -- PLUS SUPERSCRIPT SHORTCUT
    s(
        { trig = "([%a%)%]%}])%+%+", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t "+",
        }),
        { condition = tex.in_mathzone }
    ),
    -- COMPLEMENT SUPERSCRIPT
    s(
        { trig = "([%a%)%]%}])CC", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t "\\complement",
        }),
        { condition = tex.in_mathzone }
    ),
    -- CONJUGATE (STAR) SUPERSCRIPT SHORTCUT
    s(
        { trig = "([%a%)%]%}])%*%*", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t "*",
        }),
        { condition = tex.in_mathzone }
    ),
    -- BINOMIAL SYMBOL
    s(
        { trig = "([^%\\])bnn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\binom{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- LOGARITHM WITH BASE SUBSCRIPT
    s(
        { trig = "([^%a%\\])ll", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\log_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
        }),
        { condition = tex.in_mathzone }
    ),
    -- DERIVATIVE with numerator and denominator
    s(
        { trig = "([^%a])dvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\dv{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- DERIVATIVE with numerator, denominator, and higher-order argument
    s(
        { trig = "([^%a])ddv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\dvN{<>}{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
            i(3),
        }),
        { condition = tex.in_mathzone }
    ),
    -- PARTIAL DERIVATIVE with numerator and denominator
    s(
        { trig = "([^%a])pvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\pdv{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- PARTIAL DERIVATIVE with numerator, denominator, and higher-order argument
    s(
        { trig = "([^%a])ppv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\pdvN{<>}{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
            i(3),
        }),
        { condition = tex.in_mathzone }
    ),
    -- SUM with lower limit
    s(
        { trig = "([^%a])sM", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\sum_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
        }),
        { condition = tex.in_mathzone }
    ),
    -- SUM with upper and lower limit
    s(
        { trig = "([^%a])smm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\sum_{<>}^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- INTEGRAL with upper and lower limit
    s(
        { trig = "([^%a])intt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\int_{<>}^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- INTEGRAL from positive to negative infinity
    s(
        { trig = "([^%a])intf", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\int_{\\infty}^{\\infty}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
        }),
        { condition = tex.in_mathzone }
    ),
    --
    -- BEGIN STATIC SNIPPETS
    --

    -- DIFFERENTIAL, i.e. \diff
    s({ trig = "df", priority = 2000, snippetType = "autosnippet" }, {
        t "\\diff",
    }, { condition = tex.in_mathzone }),
    -- BASIC INTEGRAL SYMBOL, i.e. \int
    s({ trig = "in1", snippetType = "autosnippet" }, {
        t "\\int",
    }, { condition = tex.in_mathzone }),
    -- DOUBLE INTEGRAL, i.e. \iint
    s({ trig = "in2", snippetType = "autosnippet" }, {
        t "\\iint",
    }, { condition = tex.in_mathzone }),
    -- TRIPLE INTEGRAL, i.e. \iiint
    s({ trig = "in3", snippetType = "autosnippet" }, {
        t "\\iiint",
    }, { condition = tex.in_mathzone }),
    -- CLOSED SINGLE INTEGRAL, i.e. \oint
    s({ trig = "oi1", snippetType = "autosnippet" }, {
        t "\\oint",
    }, { condition = tex.in_mathzone }),
    -- CLOSED DOUBLE INTEGRAL, i.e. \oiint
    s({ trig = "oi2", snippetType = "autosnippet" }, {
        t "\\oiint",
    }, { condition = tex.in_mathzone }),
    -- GRADIENT OPERATOR, i.e. \grad
    s({ trig = "gdd", snippetType = "autosnippet" }, {
        t "\\grad ",
    }, { condition = tex.in_mathzone }),
    -- CURL OPERATOR, i.e. \curl
    s({ trig = "cll", snippetType = "autosnippet" }, {
        t "\\curl ",
    }, { condition = tex.in_mathzone }),
    -- DIVERGENCE OPERATOR, i.e. \divergence
    s({ trig = "DI", snippetType = "autosnippet" }, {
        t "\\div ",
    }, { condition = tex.in_mathzone }),
    -- LAPLACIAN OPERATOR, i.e. \laplacian
    s({ trig = "laa", snippetType = "autosnippet" }, {
        t "\\laplacian ",
    }, { condition = tex.in_mathzone }),
    -- PARALLEL SYMBOL, i.e. \parallel
    s({ trig = "||", snippetType = "autosnippet" }, {
        t "\\parallel",
    }),
    -- CDOTS, i.e. \cdots
    s({ trig = "cdd", snippetType = "autosnippet" }, {
        t "\\cdots",
    }),
    -- LDOTS, i.e. \ldots
    s({ trig = "ldd", snippetType = "autosnippet" }, {
        t "\\ldots",
    }),
    -- EQUIV, i.e. \equiv
    s({ trig = "eqq", snippetType = "autosnippet" }, {
        t "\\equiv ",
    }),
    -- SETMINUS, i.e. \setminus
    s({ trig = "stm", snippetType = "autosnippet" }, {
        t "\\setminus ",
    }),
    -- SUBSET, i.e. \subset
    s({ trig = "sbb", snippetType = "autosnippet" }, {
        t "\\subset ",
    }),
    -- APPROX, i.e. \approx
    s({ trig = "px", snippetType = "autosnippet" }, {
        t "\\approx ",
    }, { condition = tex.in_mathzone }),
    -- PROPTO, i.e. \propto
    s({ trig = "pt", snippetType = "autosnippet" }, {
        t "\\propto ",
    }, { condition = tex.in_mathzone }),
    -- COLON, i.e. \colon
    s({ trig = "::", snippetType = "autosnippet" }, {
        t "\\colon ",
    }),
    -- IMPLIES, i.e. \implies
    s({ trig = ">>", snippetType = "autosnippet" }, {
        t "\\implies ",
    }),
    -- DOT PRODUCT, i.e. \cdot
    s({ trig = ",.", snippetType = "autosnippet" }, {
        t "\\cdot ",
    }),
    -- CROSS PRODUCT, i.e. \times
    s({ trig = "xx", snippetType = "autosnippet" }, {
        t "\\times ",
    }),
}
