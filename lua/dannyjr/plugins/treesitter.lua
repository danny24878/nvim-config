-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

--  configure treesitter
treesitter.setup({
	--    enable syntax highlighting
	highlight = {
		enable = true,
		disable = { "latex" }, --deactivate Tree-sitter for LaTeX documents
	},
	-- enable indentation
	indent = { enable = true, disable = { "latex" } },

	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"json",
		"javascript",
		"typescript",
		"tsx",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"svelte",
		"graphql",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"python",
		"sql",
	}, -- auto install above language parsers
	auto_install = true,
})
