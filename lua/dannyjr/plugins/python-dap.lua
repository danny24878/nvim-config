local dap = require('dap')
local dap_python = require('dap-python')

-- Usa cdebugpy de Homebrew
dap_python.setup('/opt/homebrew/bin/cdebugpy')

-- Configuración para debugpy
dap.adapters.python = {
  type = 'executable',
  command = '/opt/homebrew/bin/cdebugpy',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      return '/opt/homebrew/bin/python3'  -- Ajusta según tu instalación
    end,
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Django',
    program = '${workspaceFolder}/manage.py',
    args = { 'runserver', '--noreload' },
    django = true,
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Flask',
    program = function()
      return vim.fn.getcwd() .. '/app.py'  -- Ajusta según tu estructura
    end,
    args = { 'run' },
  },
}

-- Atajos de teclado
vim.keymap.set('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set('n', '<leader>dc', ":lua require'dap'.continue()<CR>")
vim.keymap.set('n', '<leader>do', ":lua require'dap'.step_over()<CR>")
vim.keymap.set('n', '<leader>di', ":lua require'dap'.step_into()<CR>")
vim.keymap.set('n', '<leader>dO', ":lua require'dap'.step_out()<CR>")
vim.keymap.set('n', '<leader>dr', ":lua require'dap'.repl.open()<CR>")
