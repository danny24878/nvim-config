
-- ~/.config/nvim/lua/dannyjr/keymaps.lua

local keymap = vim.keymap
local ls = require("luasnip")  -- Asegúrate de tener LuaSnip instalado

-- Deshabilitar grabación de macros para evitar accidentes
keymap.set('n', 'q', '<Nop>', { noremap = true, silent = true })
keymap.set('n', 'Q', '<Nop>', { noremap = true, silent = true })

-- Líderes
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

---------------------
-- General Keymaps
---------------------

-- Mejor control para snippets con Ctrl-s (expansión de snippet)
keymap.set({ "i", "s" }, "<C-s>", function()
  if ls.expandable() then
    ls.expand()
  else
    return vim.api.nvim_replace_termcodes("<C-s>", true, true, true)
  end
end, { expr = true, silent = true })

-- Salida rápida del modo insert: jk
keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })

-- Ir al final de línea con 'aa' en insert mode
keymap.set("i", "aa", "<Esc>A", { noremap = true, silent = true })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { noremap = true, silent = true })

-- Manejo de registros
keymap.set("n", "<leader>P", ":registers<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>0", '"0p', { noremap = true, silent = true })
keymap.set("n", "<leader>1", '"1p', { noremap = true, silent = true })

-- Delete sin copiar
keymap.set("n", "x", '"_x', { noremap = true, silent = true })

-- Incremento/decremento de números
keymap.set("n", "<leader>+", "<C-a>", { noremap = true, silent = true })
keymap.set("n", "<leader>-", "<C-x>", { noremap = true, silent = true })

-- Window management (divisiones)
keymap.set("n", "<leader>sv", "<C-w>v", { noremap = true, silent = true }) -- Vertical split
keymap.set("n", "<leader>sh", "<C-w>s", { noremap = true, silent = true }) -- Horizontal split
keymap.set("n", "<leader>se", "<C-w>=", { noremap = true, silent = true }) -- Igualar tamaño
keymap.set("n", "<leader>sx", ":close<CR>", { noremap = true, silent = true }) -- Cerrar ventana

-- Moverse entre ventanas con Ctrl+h/j/k/l
keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })

-- Pestañas
keymap.set("n", "<leader>to", ":tabnew<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>tn", ":tabnext<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>tp", ":tabprevious<CR>", { noremap = true, silent = true })

---------------------
-- Plugin Keybinds
---------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { noremap = true, silent = true })

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- telescope (búsquedas)
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })

-- telescope git
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { noremap = true, silent = true })

-- restart LSP server y recarga snippets
keymap.set("n", "<leader>tt", function()
  require("luasnip.loaders.from_lua").load({ paths = vim.fn.expand("~/.config/nvim/lua/dannyjr/luasnip/") })
  vim.cmd("LspRestart")
  print("Snippets y LSP reiniciados")
end, { noremap = true, silent = true })

---------------------
-- LuaSnip keymaps para expandir/jump de snippets con Tab y Shift-Tab
---------------------

keymap.set({ "i", "s" }, "<Tab>", function(fallback)
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  else
    fallback()
  end
end, { silent = true, expr = true })

keymap.set({ "i", "s" }, "<S-Tab>", function(fallback)
  if ls.jumpable(-1) then
    ls.jump(-1)
  else
    fallback()
  end
end, { silent = true, expr = true })

---------------------
-- Guardado rápido
---------------------
keymap.set("n", "<leader>ss", ":w<CR>", { noremap = true, silent = true })

---------------------
-- Función para salir inteligentemente de delimitadores
---------------------
function _G.smart_move_out()
  local col = vim.fn.col(".")
  local line = vim.fn.getline(".")
  if col > #line then
    return vim.api.nvim_replace_termcodes("<Right>", true, true, true)
  end
  local next_char = string.sub(line, col, col)
  local delimiters = { ")", ">", "]", "}", '"', "'", "\\", " ", "$" }
  if vim.tbl_contains(delimiters, next_char) then
    return vim.api.nvim_replace_termcodes("<Right>", true, true, true)
  else
    return "ss" -- fallback, si quieres que no haga nada, puedes poner ''
  end
end

keymap.set("i", "ss", "v:lua.smart_move_out()", { expr = true, noremap = true, silent = true })

