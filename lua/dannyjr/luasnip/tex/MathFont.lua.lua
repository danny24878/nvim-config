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
local mathbb_conjuntos = {
	["RR"] = "\\mathbb{R}",
	["QQ"] = "\\mathbb{Q}",
	["ZZ"] = "\\mathbb{Z}",
	["NN"] = "\\mathbb{N}",
	["CC"] = "\\mathbb{C}",
}

---------------------------------------------------------------------

return {
	-- Fuente en negrita matemática (\mathbf{})
	s(
		{
			trig = "([^%a])mbf",
			dscr = "Fuente matemática en negrita",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\mathbf{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),
	---------- Fuente cursiva
	s(
		{
			trig = "([^%a])mscr",
			dscr = "Fuente matemática en negrita",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\mathscr{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	-- Fuente matemática en caligráfica (\mathcal{})
	s(
		{
			trig = "([^%a])mcal",
			dscr = "Fuente matemática en caligráfica",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\mathcal{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	-- Fuente matemática en doble línea (\mathbb{})
	s(
		{
			trig = "([^%a])mbb",
			dscr = "Fuente matemática en doble línea",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\mathbb{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	-- Fuente matemática en gótica (\mathfrak{})
	s(
		{
			trig = "([^%a])mfk",
			dscr = "Fuente matemática en gótica",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\mathfrak{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	-- Fuente matemática en sans-serif (\mathsf{})
	s(
		{
			trig = "([^%a])msf",
			dscr = "Fuente matemática en sans-serif",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\mathsf{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),

			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	-- Fuente matemática en tipo máquina de escribir (\mathtt{})
	s(
		{
			trig = "([^%a])mtt",
			dscr = "Fuente matemática en monoespaciado",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>\\mathtt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),
	s(
		{
			trig = "([A-N-M-WY-Z])%1", -- Doble mayúscula: AA, BB, CC, etc.
			regTrig = true,
			dscr = "Cualquier doble mayúscula → mathbb",
			snippetType = "autosnippet",
			priority = 3000, -- Prioridad muy alta
		},
		fmta("\\mathbb{<>}", {
			f(function(_, snip)
				return snip.captures[1] -- Captura la letra (A, B, C, etc.)
			end),
		}),
		{ condition = in_mathzone }
	),
}
