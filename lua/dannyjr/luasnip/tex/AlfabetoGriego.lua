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

local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return {
	s({
		trig = "alph",
		dscr = "alpha",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\alpha"), { condition = in_mathzone }),
	s({
		trig = "gam",
		dscr = "gamma",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\gamma"), { condition = in_mathzone }),
	s({
		trig = "delt",
		dscr = "delta",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\delta"), { condition = in_mathzone }),
	s({
		trig = "Del",
		dscr = "delta",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\Delta"), { condition = in_mathzone }),
	s({
		trig = "epsi",
		dscr = "varespilon",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\varepsilon"), { condition = in_mathzone }),
	s({
		trig = "zet",
		dscr = "zeta",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\zeta"), { condition = in_mathzone }),
	s({
		trig = "eta",
		dscr = "eta",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\eta"), { condition = in_mathzone }),
	s({
		trig = "thet",
		dscr = "theta",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\theta"), { condition = in_mathzone }),
	s({
		trig = "Thet",
		dscr = "Theta",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\Theta"), { condition = in_mathzone }),
	s({
		trig = "iot",
		dscr = "Diferencial",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\diff"), { condition = in_mathzone }),
	s({
		trig = "kap",
		dscr = "kappa",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\kappa"), { condition = in_mathzone }),
	s({
		trig = "Lam",
		dscr = "Lambda",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\Lambda"), { condition = in_mathzone }),
	s({
		trig = "lam",
		dscr = "lambda",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\lambda"), { condition = in_mathzone }),
	s({
		trig = "mu",
		dscr = "mu",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\mu"), { condition = in_mathzone }),
	s({
		trig = "nu",
		dscr = "nu",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\nu"), { condition = in_mathzone }),
	s({
		trig = "xi",
		dscr = "xi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\xi"), { condition = in_mathzone }),
	s({
		trig = "Xi",
		dscr = "Xi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\lambda"), { condition = in_mathzone }),
	s({
		trig = "pi",
		dscr = "pi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\pi"), { condition = in_mathzone }),
	s({
		trig = "Pi",
		dscr = "Pi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\Pi"), { condition = in_mathzone }),
	s({
		trig = "rho",
		dscr = "rho",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\rho"), { condition = in_mathzone }),
	s({
		trig = "vrho",
		dscr = "varrho",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\varrho"), { condition = in_mathzone }),
	s({
		trig = "sig",
		dscr = "sigma",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\sigma"), { condition = in_mathzone }),
	s({
		trig = "Sig",
		dscr = "Sigma",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\Sigma"), { condition = in_mathzone }),
	s({
		trig = "tau",
		dscr = "tau",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\tau"), { condition = in_mathzone }),
	s({
		trig = "ups",
		dscr = "upsilon",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\upsilon"), { condition = in_mathzone }),
	s({
		trig = "Ups",
		dscr = "Upsilon",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\Upsilon"), { condition = in_mathzone }),
	s({
		trig = "phi",
		dscr = "phi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\phi"), { condition = in_mathzone }),
	s({
		trig = "vphi",
		dscr = "vphi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
		priority = 2000,
	}, t("\\varphi"), { condition = in_mathzone }),
	s({
		trig = "Phi",
		dscr = "Phi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\Phi"), { condition = in_mathzone }),
	s({
		trig = "chi",
		dscr = "chi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\chi"), { condition = in_mathzone }),
	s({
		trig = "psi",
		dscr = "psi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\psi"), { condition = in_mathzone }),
	s({
		trig = "Psi",
		dscr = "Psi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\Psi"), { condition = in_mathzone }),
	s({
		trig = "Psi",
		dscr = "Psi",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\Psi"), { condition = in_mathzone }),
	s({
		trig = "ome",
		dscr = "omega",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\omega"), { condition = in_mathzone }),
	s({
		trig = "Ome",
		dscr = "Omega",
		snippetType = "autosnippet",
		regTrig = true,
		wordTrig = false,
	}, t("\\Omega"), { condition = in_mathzone }),
}
