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
	if #parent.snippet.env.SELECT_RAW > 0 then
		return sn(nil, t(parent.snippet.env.SELECT_RAW))
	else
		return sn(nil, i(1))
	end
end

-- Detectar si estamos en un entorno matemático (LaTeX)
local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return {
	-- ========== FRACCIONES Y NOTACIÓN BÁSICA ==========
	s(
		{
			trig = "([^%a])ff",
			dscr = "Fracción con carácter previo",
			snippetType = "autosnippet",
			regTrig = true,
			wordTrig = false,
		},
		fmta("<>\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end), -- Carácter previo
			d(1, get_visual), -- Numerador
			i(2), -- Denominador
		}),
		{ condition = in_mathzone }
	),
	s(
		{
			trig = "([^%a])dsum",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "suma definida",
		},
		fmta("<>\\sum_{<>}^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1, "k = 1"),
			i(2, "n"),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])leq",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "meno que",
		},
		fmta("<>\\leq<>", {
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
			trig = "([^%a])geq",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "mayor que",
		},
		fmta("<>\\geq<>", {
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
			trig = "([^%a])sum",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "suma",
		},
		fmta("<>\\sum<>", {
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
			trig = "([^%a])nroot",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "nth-root",
		},
		fmta("<>\\sqrt[<>]<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(2),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),

	s(
		{
			trig = "([^%a])sqr",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "square root",
		},
		fmta("<>\\sqrt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),
}
