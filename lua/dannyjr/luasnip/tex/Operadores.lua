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
			trig = "([^%a])nn",
			dscr = "Nabla",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\nabla<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),

	-- Perpendicular
	s(
		{
			trig = "([^%a\\])perp>",
			dscr = "Perpendicular",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\perp<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = in_mathzone }
	),

	-- Producto cuña (trigger optimizado)
	s(
		{
			trig = "([^%a])ww", -- De ":w" a "w"
			dscr = "Producto cuña",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\wedge<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = in_mathzone }
	),

	-- Cuña invertida (nombre mejorado)
	s(
		{
			trig = "([^%a])vv", -- De ":v" a "v"
			dscr = "Cuña invertida",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\vee<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = in_mathzone }
	),

	s(
		{
			trig = "([^%a])hom",
			dscr = "Homeomorfismo",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\simeq<>", {
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
			trig = "([^%a])iiso",
			dscr = " Isomorfismo",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\cong<>", {
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
			trig = "([^%a])equiv",
			dscr = "equivalencia",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\equiv<>", {
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
			trig = "([^%a])perp",
			dscr = "Perpendicular",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\perp<>", {
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
			trig = "([^%a])oplus",
			dscr = "Suma directa",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\oplus<>", {
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
			trig = "([^%a\\])xprod>",
			dscr = "producto directo",
			regtrig = true,
			wordtrig = false,
			snippettype = "autosnippet",
		},
		fmta("<>\\otimes<>", {
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
