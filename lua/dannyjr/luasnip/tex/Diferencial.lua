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
	-- Número de Euler (e^{...})
	s(
		{
			trig = "([^%a])ee",
			dscr = "Exponencial de Euler",
			snippetType = "autosnippet",
			regTrig = true,
			wordTrig = false,
		},
		fmta("<>e^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	-- ========== CÁLCULO DIFERENCIAL ==========
	-- Derivada ordinaria
	s(
		{
			trig = "dv",
			regTrig = true,
			wordTrig = false,
			dscr = "Derivada ordinaria",
			snippetType = "autosnippet",
		},
		fmta("\\frac{\\diff <>}{\\diff <>}", {
			i(1, "x"),
			i(2, "t"),
		}),
		{ condition = in_mathzone }
	),

	-- Derivada parcial (corregido a \partial)
	s(
		{
			trig = "pd",
			dscr = "Derivada parcial",
			snippetType = "autosnippet",
			regTrig = true,
			wordTrig = false,
		},
		fmta("\\frac{\\pd <>}{\\pd <>}", {
			i(1, "x"),
			i(2, "t"),
		}),
		{ condition = in_mathzone }
	),

	-- Diferencial
	s({
		trig = "dd",
		dscr = "Diferencial",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\diff"), { condition = in_mathzone }),
  	-- Diferencial parcial
	s({
		trig = "dp",
		dscr = "Diferencial parcial",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\partial"), { condition = in_mathzone }),

}
