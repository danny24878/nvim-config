local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta
local d = ls.dynamic_node
local i = ls.insert_node
local f = ls.function_node

-- Función para verificar modo texto (opuesta a mathzone)
local in_text = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() ~= 1
end

-- Función get_visual (asegúrate de tenerla definida)
local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else
		return sn(nil, i(1))
	end
end

return {
  -- Italica
	s(
		{
			trig = "([^%a])tit",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Texto en italica",
		},
		fmta("<>\\textit{<>}<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2), -- Campo adicional para continuar escribiendo
		}),
		{ condition = in_text } -- Solo en modo texto
	),
	-- Negrita (texto)
	s(
		{
			trig = "([^%a])tbf",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Texto en negrita",
		},
		fmta("<>\\textbf{<>}<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2), -- Campo adicional para continuar escribiendo
		}),
		{ condition = in_text } -- Solo en modo texto
	),

	-- Cursiva (texto)
	s(
		{
			trig = "([^%a])tti",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Texto en cursiva",
		},
		fmta("<>\\textit{<>}<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = in_text }
	),

	-- Monoespaciado (texto)
	s(
		{
			trig = "([^%a])ttt",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Texto monoespaciado",
		},
		fmta("<>\\texttt{<>}<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = in_text }
	),

	-- Versalitas (texto)
	s(
		{
			trig = "([^%a])tsc",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Texto en versalitas",
		},
		fmta("<>\\textsc{<>}<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = in_text }
	),

	-- Sans-serif (texto)
	s(
		{
			trig = "([^%a])tsf",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Texto sans-serif",
		},
		fmta("<>\\textsf{<>}<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = in_text }
	),

	-- Serif (texto)
	s(
		{
			trig = "([^%a])trm",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Texto serif",
		},
		fmta("<>\\textrm{<>}<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = in_text }
	),

	-- Texto en matemáticas (modo texto dentro de fórmulas)
	s(
		{
			trig = "([^%a])txt",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Texto en modo matemático",
		},
		fmta("<>\\text{<>}<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = in_mathzone } -- Solo en modo matemático
	),
}
