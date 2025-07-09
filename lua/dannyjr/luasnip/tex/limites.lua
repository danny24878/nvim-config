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
			trig = "([^%a])lim",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "limite",
		},
		fmta("<>\\lim_{<> \\rightarrow <>} <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
			i(3),
		}),
		{
			condition = in_mathzone,
		}
	),

	s(
		{
			trig = "([^%a])dlim",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "limite",
		},
		fmta("<>\\lim_{<> \\rightarrow <>} <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
			i(3),
		}),
		{
			condition = in_mathzone,
		}
	),

	s(
		{
			trig = "([^%a])slim",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "limite superior",
		},
		fmta("<>\\limsup\\limits_{<> \\rightarrow <>} <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
			i(3),
		}),
		{
			condition = in_mathzone,
		}
	),
	s(
		{
			trig = "([^%a])ilim",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "limite inferior",
		},
		fmta("<>\\liminf\\limits_{<> \\rightarrow <>} <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
			i(3),
		}),
		{
			condition = in_mathzone,
		}
	),
}
