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

-- Detectar si estamos en un entorno matemático (LaTeX)
local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
return {
	-- Homeomorfismo
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
		{ condition = in_mathzone }
	),
	-- Isomorfismo (descripción corregida)
	s(
		{
			trig = "([^%a])iiso",
			dscr = "Isomorfismo", -- Sin espacio inicial
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
		{ condition = in_mathzone }
	),

	-- Equivalencia (mayúscula inicial)
	s(
		{
			trig = "([^%a])equi",
			dscr = "Equivalencia",
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
		{ condition = in_mathzone }
	),
	s({
		trig = "inft",
		dscr = "Infinito",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
	}, t("\\infty"), { condition = in_mathzone }),
	s({
		trig = "exis",
		dscr = "Infinito",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
    priority = 3000,
	}, t("\\exist"), { condition = in_mathzone }),
	s({
		trig = "nexis",
		dscr = "Infinito",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
    priority = 3000,
	}, t("\\nexist"), { condition = in_mathzone }),


	s({
		trig = "fll",
		dscr = "forall",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
	}, t("\\forall"), { condition = in_mathzone }),
	s({
		trig = ":exi",
		dscr = "exist",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
	}, t("\\exists"), { condition = in_mathzone }),
	s({
		trig = "cir",
		dscr = "Infinito",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
	}, t("\\circle"), { condition = in_mathzone }),
	s({
		trig = "cd",
		dscr = "cdot",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
	}, t("\\cdot"), { condition = in_mathzone }),
	s({
		trig = "cds",
		dscr = "cdots",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
	}, t("\\cdots"), { condition = in_mathzone }),
	s(
		{
			trig = "([^%a])obar",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "Función indicadora",
		},
		fmta("<>\\overline{<>}", {
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
			trig = "([^%a])xbar",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "barra arriba",
			priority = 2000,
		},
		fmta("<>\\xoverline{<>}", {
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
			trig = "([^%a])bar",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "barra más pequeña",
			priority = 2000,
		},
		fmta("<>\\bar{<>}", {
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
			trig = "([^%a])ubar",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "barra abajo",
			priority = 2000,
		},
		fmta("<>\\underline{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
		}
	),
  	s({
		trig = "eq",
		dscr = "equal",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
	}, t("="), { condition = in_mathzone }),
	s({
		trig = "neq",
		dscr = "not equal",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
	}, t("\\neq"), { condition = in_mathzone }),
 	s(
		{
			trig = "([^%a])sup",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "supremo",
		},
		fmta("<> \\text{sup}\\set{ <> ; <>} ", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
      i(2),
		}),
		{
			condition = in_mathzone,
		}
	),
s(
		{
			trig = "([^%a])ínf",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "infimo",
			priority = 2000,
		},
		fmta("<> \\text{ínf} \\set{ <> ; <>} ", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
      i(2),
		}),
		{
			condition = in_mathzone,
		}
	),
}
