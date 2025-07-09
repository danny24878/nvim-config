-- ~/.config/nvim/ftplugin/python.lua

-- Configuración de indentación
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.smartindent = true

-- Atajos
local keymap = vim.keymap.set
local opts = { buffer = true }


-- Ejecutar archivo Python con entorno detectado
keymap('n', '<leader>rv', function()
  local file = vim.fn.shellescape(vim.fn.expand('%:p'))
  local python_path = nil

  -- Detectar entorno conda
  local conda_prefix = os.getenv("CONDA_PREFIX")
  if conda_prefix then
    local candidate = conda_prefix .. (vim.loop.os_uname().sysname == "Windows_NT" and "\\Scripts\\python.exe" or "/bin/python")
    if vim.fn.executable(candidate) == 1 then
      python_path = candidate
    end
  end

  -- Fallback a Python global
  if not python_path then
    python_path = 'python'
  end

  vim.cmd('!' .. python_path .. ' ' .. file)
end, opts)

-- Snippets con LuaSnip
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets('python', {
  s('main', fmt([[if __name__ == "__main__":
    {}
  ]], { i(0) })),

  s('cls', fmt([[class {}:
    """{}"""

    def __init__(self, {}):
        {}
  ]], {
    i(1, "ClassName"),
    i(2, "Docstring"),
    i(3, "args"),
    i(0)
  })),

  s('def', fmt([[def {}({}) -> {}:
    """{}"""
    {}
  ]], {
    i(1, "func"),
    i(2, "args"),
    i(3, "None"),
    i(4, "Docstring"),
    i(0)
  })),

  s('for', fmt([[for {} in {}:
    {}
  ]], { i(1, "item"), i(2, "iterable"), i(0) })),

  s('while', fmt([[while {}:
    {}
  ]], { i(1, "condition"), i(0) })),
})

-- Diagnósticos
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
