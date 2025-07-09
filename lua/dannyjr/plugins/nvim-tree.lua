
-- lua/dannyjr/configs/nvim-tree.lua
-- Configuración para nvim-tree.lua

-- Deshabilitar netrw (recomendado)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Resaltar indent markers con color amarillo (ajusta al gusto)
vim.cmd([[highlight NvimTreeIndentMarker guifg=#f7c620]])

-- Setup nvim-tree
require("nvim-tree").setup({
  view = {
    width = 35,
    relativenumber = true,
  },
  renderer = {
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "",
          arrow_open = "",
        },
      },
    },
  },
  actions = {
    open_file = {
      window_picker = { enable = false },
    },
  },
  filters = {
    custom = { ".DS_Store" },
  },
  git = { ignore = false },
})

-- Keymaps para nvim-tree
local keymap = vim.keymap
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer", noremap = true, silent = true })
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle explorer on current file", noremap = true, silent = true })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer", noremap = true, silent = true })
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer", noremap = true, silent = true })
