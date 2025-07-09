local ls = require("luasnip")
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
	else
		return sn(nil, i(1))
	end
end

-- Condiciones para modos matemáticos/texto
local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local in_text = function()
	return not in_mathzone()
end

-- Función para guardar la posición actual del cursor
local save_position = function()
	return vim.api.nvim_win_get_cursor(0) -- Retorna [fila, columna]
end

-- Función para restaurar la posición guardada
local restore_position = function(_, _, snip)
	if snip.saved_pos then
		vim.api.nvim_win_set_cursor(0, snip.saved_pos)
	end
	return ""
end

---------------------------------------------------------------------
return {
	-- Snippet para modo matemático corregido
	s(
		{ trig = "([^%a])mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>$<>$", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = in_text } -- Opciones como TERCER argumento
	),
	-- Entorno matematico
	s(
		{ trig = "([^%a])nn", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
      <>
      \begin{equation*}
        <> 
      \end{equation*}
    ]],
			{
				f(function(_, snip)
					return snip.captures[1]
				end),
				d(1, get_visual),
			}
		),
		{ condition = in_text } -- Opciones como TERCER argumento
	),

	-- Texto en itálica corregido
	s(
		{ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command.", wordTrig = false },
		fmta("\\textit{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_text } -- Opciones aquí
	),

	-- Subíndices con 'kk'
	s(
		{
			trig = "([%a%)%]%}])kk",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end), -- Captura la base
			d(1, get_visual), -- Contenido del subíndice
		}),
		{ condition = in_mathzone }
	),

	-- Superíndices con 'qq'
	s(
		{
			trig = "([%a%)%]%}])qq",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
		},
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end), -- Captura la base
			d(1, get_visual), -- Contenido del superíndice
		}),
		{ condition = in_mathzone }
	),

	-- Versión para cuando no hay caracter previo (solo 'kk' o 'ww')
	s(
		{ trig = "kk", wordTrig = false, snippetType = "autosnippet" },
		fmta("_{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ trig = "qq", wordTrig = false, snippetType = "autosnippet" },
		fmta("^{<>}", {
			d(1, get_visual),
		}),
		{ condition = in_mathzone }
	),
}
