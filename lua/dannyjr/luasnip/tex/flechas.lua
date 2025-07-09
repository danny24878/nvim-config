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
	-- Flecha derecha mejorada
	s(
		{
			trig = "([^%a]):r", -- Mejor trigger: ej. x;r → x→
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "Flecha derecha con contexto",
		},
		fmta("<>\\rightarrow <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1), -- Campo para contenido posterior
		}),
		{ condition = in_mathzone }
	),
	-- Flecha derecha mejorada
	s(
		{
			trig = "([^%a])then", -- Mejor trigger: ej. x;r → x→
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "Flecha derecha con contexto",
		},
		fmta("<>\\Rightarrow <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1), -- Campo para contenido posterior
		}),
		{ condition = in_mathzone }
	),

	s(
		{
			trig = "([^%a]):lr", -- Mejor trigger: ej. x;r → x→
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "Flecha derecha con contexto",
		},
		fmta("<>\\mapsto <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1), -- Campo para contenido posterior
		}),
		{ condition = in_mathzone }
	),

	-- Flecha bidireccional para "si y solo si"
	s(
		{
			trig = "([^%a])iff", -- Ej: a;iff → a⇔
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "Doble flecha lógica",
		},
		fmta("<>\\Leftrightarrow <>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1), -- Campo para el otro lado de la equivalencia
		}),
		{ condition = in_mathzone }
	),
}
