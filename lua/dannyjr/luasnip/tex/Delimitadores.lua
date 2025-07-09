local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
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
			trig = ":del", -- trigger para insertar \del
			dscr = "Inserta comando \\del con delimitador seleccionado",
			snippetType = "autosnippet",
		},
		fmta([[\del{<>}{<>}]], {
			-- Primer argumento: elección entre distintos delimitadores
			c(1, {
				t("()"),
				t("[]"),
				t("{}"),
				t("||"),
				t("<>"),
			}),
			-- Segundo argumento: si se tiene texto seleccionado se inserta,
			-- en caso contrario se muestra un nodo de inserción.
			d(2, function(_, snip)
				if snip.env.TM_SELECTED_TEXT then
					return sn(1, t(snip.env.TM_SELECTED_TEXT))
				else
					return sn(1, i(1))
				end
			end),
		}, { delimiters = "<>" })
	),
	---
	s(
		{
			trig = "delim",
			wordTrig = false,
			regTrig = true,
			dscr = "Delimitadores personalizados con apertura/cierre diferentes",
			snippetType = "autosnippet",
		},
		fmta([[\delim{<>}{<>}{<>}]], {
			i(1, "("), -- Delimitador de apertura (editable)
			i(2, ")"), -- Delimitador de cierre (editable)
			d(3, function(_, snip)
				if snip.env.TM_SELECTED_TEXT then
					return sn(1, t(snip.env.TM_SELECTED_TEXT))
				else
					return sn(1, i(1, "CONTENIDO"))
				end
			end),
		}),
		{
			condition = in_mathzone,
			callback = function() end,
		}
	),

	-- Snippet 3: Delimitador rápido con ; (captura del delimitador de apertura)
	s(
		{
			trig = ";([%(%[%{<|])", -- Captura ; seguido del delimitador de apertura
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Delimitador rápido con ;",
			priority = 3000, -- Prioridad mayor para sobrescribir el snippet principal
		},
		fmta([[\del{<>}{<>}]], {
			f(function(_, snip)
				local pairs = {
					["("] = "()",
					["["] = "[]",
					["{"] = "{}",
					["<"] = "<>",
					["|"] = "||",
				}
				return pairs[snip.captures[1]]
			end),
			i(1),
		}),
		{
			condition = in_mathzone,
			callback = function() end,
		}
	),
s(
    {
        trig = "oo",
        dscr = "Paréntesis con selección o cursor",
        regTrig = false,
        wordTrig = false,
        snippetType = "autosnippet",
    },
    fmta("\\left( <> \\right)", {
        d(1, function(_, snip)
            if #snip.env.LS_SELECT_RAW > 0 then
                return sn(1, t(snip.env.LS_SELECT_RAW))
            else
                return sn(1, i(1))
            end
        end),
    }),
    { condition = in_mathzone }
),
    
}
