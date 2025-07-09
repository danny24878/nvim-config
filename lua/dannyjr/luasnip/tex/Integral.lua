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
			trig = "([^%a])mint",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "integral",
		},
		fmta("<>\\int_{<>} <> \\diff <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1, "X"),
			i(2, "f"),
			i(3, "x"),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])int",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "integral",
		},
		fmta("<>\\int <> \\diff <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2, "x"),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])dint",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "integral",
		},
		fmta("<>\\int_{<>}^{<>} <> \\diff <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1, "a"),
			i(2, "b"),
			i(3, "f(x)"),
			i(4, "x"),
		}),
		{
			condition = in_mathzone,
		}
	),
}
