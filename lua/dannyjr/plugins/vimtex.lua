return {
	"lervag/vimtex",
	init = function()
		-- Configuración principal
		vim.g.vimtex_compiler_method = "lualatex" -- Fuerza uso de LuaLaTeX
		vim.g.vimtex_compiler_latexmk = {
			options = {
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				"-interaction=nonstopmode",
				"-synctex=1",
			},
		}

		-- Configuración del visor PDF (Skim para macOS)
		vim.g.vimtex_view_method = "skim"
		vim.g.vimtex_view_skim_sync = 1 -- SyncTeX support
		vim.g.vimtex_view_skim_activate = 1

		-- Mejor manejo de errores
		vim.g.vimtex_quickfix_mode = 1 -- Habilita el quickfix para ver errores
		vim.g.vimtex_quickfix_ignore_filters = {
			"Package fontspec Warning",
			"Overfull",
			"Underfull",
			"Token not allowed in a PDF string",
		}

		-- Deshabilita las advertencias de paquetes
		vim.g.vimtex_log_verbose = 0

		-- Mejor manejo de la indentación
		vim.g.vimtex_indent_enabled = 1 -- Mejor usar la indentación de VimTeX
		vim.g.vimtex_indent_on_ampersands = 0

		-- Configuración específica para LuaLaTeX
		vim.g.vimtex_syntax_lualatex = 1
		vim.g.tex_flavor = "lualatex" -- Fuerza detección de LuaLaTeX

		-- Autocomandos mejorados
		vim.cmd([[
        augroup VimTeXConfig
            autocmd!
            autocmd FileType tex setlocal foldmethod=expr foldexpr=vimtex#fold#level(v:lnum)
            autocmd FileType tex setlocal foldtext=vimtex#fold#text()
            " Latexindent con opciones específicas para Unicode
            autocmd BufWritePre *.tex silent! execute '%!latexindent -l -m 2>/dev/null'
        augroup END
        ]])
	end,
	config = function()
		-- Mapeos personalizados
		vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<cr>", { desc = "Compilar LaTeX" })
		vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<cr>", { desc = "Ver PDF" })
	end,
}
