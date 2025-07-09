-- Abbreviations used in this article and the LuaSnip docs
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

local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- if LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1 -- Fixed typo here
end

local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else
		return sn(nil, i(1))
	end
end

return {
	s(
		{
			trig = "([a-zA-Z])pp",
			regTrig = true,
			dscr = "Parte positiva",
			snippetType = "autosnippet",
		},
		fmta(
			"<>^{+}<>",
			{
				f(function(_, snip)
					return snip.captures[1]
				end), -- Coma añadida
				d(1, get_visual), -- Coma correcta
			} -- Cierre de tabla
		), -- Cierre de fmta
		{ condition = in_mathzone } -- Condición
	), -- Cierre del snippet

	s(
		{
			trig = "([a-zA-Z])mm",
			regTrig = true,
			dscr = "Parte negativa",
			snippetType = "autosnippet",
		},
		fmta("<>^{-}<>", {
			f(function(_, snip)
				return snip.captures[1]
			end), -- Coma añadida
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),
	s({
		trig = ";A",
		dscr = "A cursiva",
		regTrig = false,
		wordTrig = true, -- Evita colisiones
		snippetType = "autosnippet",
	}, t("\\mathscr{A}"), { condition = in_mathzone }),
	s(
		{
			trig = ";11",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "Función indicadora",
		},
		fmta("<>\\mathbbm{1}_{<>}", {
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
			trig = "LL",
			regTrig = true,
			snippetType = "autosnippet",
			wordTrig = false,
			dscr = "Función indicadora",
			priority = 2000,
		},
		fmta("<>\\mathcal{L}^{n}(<>)", {
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
        trig = "sop",
        dscr = "sop",
        regTrig = false,  -- Cambiado a false ya que no necesitas regex
        wordTrig = true,  -- Mejor para evitar activaciones accidentales
        snippetType = "autosnippet",
        priority = 3000,
    },
    fmta("\\text{sop}(<>)", {  -- Corregido el formato
        i(1),  -- Nodo de inserción dentro del paréntesis
    }),
    {
    condition = function(line_to_cursor)
        return in_mathzone() and line_to_cursor:match("sop$")
    end
}
)
}
