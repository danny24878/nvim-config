local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- Obtener texto visualmente seleccionado
local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else
		return sn(nil, i(1))
	end
end

-- Detectar si estamos en un entorno matemático (LaTeX)
local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return {
	s(
		{
			trig = "([^%a])cup",
			dscr = "union",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\cup<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])cap",
			dscr = "Intersección",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\cap<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])Cup",
			dscr = "union",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\bigcup<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),

	s(
		{
			trig = "([^%a]):Cup",
			dscr = "unión definida",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\bigcup_{<>}^{<>} <> ", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1, "k = 1"),
			i(2, "\\infty"),
			i(3),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a]):Cap",
			dscr = "Intersección definida",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\bigcap_{<>}^{<>} <> ", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1, "k = 1"),
			i(2, "\\infty"),
			i(3),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])Cap",
			dscr = "union",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\bigcap<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),
	-- Conjunto potencia
	s(
		{
			trig = "([^%a]):Ps",
			dscr = "Conjunto potencia",
			snippetType = "autosnippet",
		},
		fmta("\\mathcal{P}(<>)", {
			i(1, "X"),
		}),
		{ condition = in_mathzone }
	),
	s(
		{
			trig = "([^%a])empty",
			dscr = "Conjunto vacío",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\emptyset", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])inn",
			dscr = "pertenencia",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\in<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])sub",
			dscr = "subconjunto",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\subseteq<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])nsub",
			dscr = "no subconjunto",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\not\\subseteq<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])mset",
			dscr = "minus set",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\setminus<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])nin",
			dscr = "no pertenencia",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\notin<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])set",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "integral",
		},
		fmta("<>\\set{ <> ; <> } ", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1, "x"),
			i(2),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])dset",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
      priority = 3000,
			dscr = "integral",
		},
		fmta("<>\\set{ <> \\in <>; <> } ", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1, "x"),
			i(2, "X"),
			i(3),
		}),
		{
			condition = in_mathzone,
		}
	),
	s({
		trig = "([^%s]+)deff",
		regTrig = true,
		snippetType = "autosnippet",
		priority = 3000,
		hidden = true,
	}, {
		d(1, function(_, parent)
			local full = parent.captures[1]
			local parts = vim.split(full, ":", { plain = true })

			return sn(nil, {
				t(parts[1] or "f"),
				t(" \\colon "),
				d(1, function()
					return sn(nil, { i(1, parts[2] or "A") })
				end),
				t(" \\to "),
				d(2, function()
					return sn(nil, { i(1, parts[3] or "B") })
				end),
			})
		end),
	}, { condition = in_mathzone }),

}
