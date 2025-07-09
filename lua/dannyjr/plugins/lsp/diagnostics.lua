vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
})

-- Configura los íconos para los diagnósticos
local signs = {
  Error = "✘",
  Warn  = "▲",
  Hint  = "⚑",
  Info  = ""
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Configuración general de los diagnósticos
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Colores personalizados (opcional)
vim.cmd([[
  highlight DiagnosticError guifg=#FF0000
  highlight DiagnosticWarn  guifg=#FFA500
  highlight DiagnosticInfo  guifg=#00FFFF
  highlight DiagnosticHint  guifg=#00FF00
]])

-- Keymaps para diagnosticar rápidamente
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Mostrar diagnóstico flotante" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Diagnóstico anterior" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Siguiente diagnóstico" })
