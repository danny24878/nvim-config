-- ==================================================================
-- CONFIGURACIÓN INICIAL PARA NEOVIM CON LUSNIP Y PLUGINS MODULARES
-- ==================================================================

-- 1. PATH para Node.js y ejecutables locales
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("/opt/homebrew/bin")
.. ":" .. vim.fn.expand("$HOME/.local/bin")

-- 2. Configurar entorno Python dinámicamente (Condaprimera opción)
local function setup_python()
  local conda_prefix = os.getenv("CONDA_PREFIX")
  if conda_prefix then
    vim.g.python3_host_prog = conda_prefix .. "/bin/python"
    vim.notify("Conda detectado: " .. vim.g.python3_host_prog)
    return
  end


  -- Buscar en rutas comunes
  local python_paths = {
    "/opt/homebrew/bin/python3",
    "/usr/local/bin/python3",
    "/usr/bin/python3",
    os.getenv("HOME") .. "/miniconda3/bin/python3",
    "/opt/miniconda3/bin/python3",
    "/usr/bin/python",
  }

  for _, path in ipairs(python_paths) do
    if vim.fn.executable(path) == 1 then
      vim.g.python3_host_prog = path
      vim.notify("Python detectado: " .. path)
      return
    end
  end

  vim.notify("⚠️ No se encontró un intérprete de Python válido.", vim.log.levels.WARN)
end

setup_python()

-- 3. Forzar inicialización de Python si está disponible
if vim.g.python3_host_prog then
  vim.cmd("silent! py3 pass")
end

-- 4. Función utilitaria para require con notificación de errores
local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Error al cargar: " .. module .. "\n" .. result, vim.log.levels.ERROR)
    return nil
  end
  return result
end

vim.o.timeoutlen = 300
vim.o.updatetime = 100

-- 5. Bootstrap y carga de plugins con Packer
safe_require("dannyjr.plugins-setup")

-- 6. Cargar configuración base
safe_require("dannyjr.core.options")
safe_require("dannyjr.core.keymaps")
safe_require("dannyjr.core.colorscheme")
safe_require("dannyjr.core.LuaSnip")

-- 7. Cargar plugins que no requieren Python
safe_require("dannyjr.plugins.comment")
safe_require("dannyjr.plugins.lualine")
safe_require("dannyjr.plugins.telescope")
safe_require("dannyjr.plugins.nvim-cmp")
safe_require("dannyjr.plugins.lsp")
safe_require("dannyjr.plugins.lsp.mason")
safe_require("dannyjr.plugins.lsp.lspconfig")
safe_require("dannyjr.plugins.autopairs")
safe_require("dannyjr.plugins.treesitter")
safe_require("dannyjr.plugins.gitsigns")
safe_require("dannyjr.plugins.vimtex")
safe_require("dannyjr.plugins.airline")
safe_require("dannyjr.plugins.nvim-surround")
safe_require("dannyjr.plugins.nvim-tree")
safe_require("dannyjr.plugins.lsp.mason")

-- 8. Configurar LuaSnip y cargar tus snippets
local luasnip = safe_require("luasnip")
if luasnip then
  luasnip.config.set_config({
    history = true,
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
    update_events = "TextChanged,TextChangedI",
  })

  -- Cargar snippets desde tu carpeta personalizada
  safe_require("luasnip.loaders.from_lua").lazy_load({
    paths = vim.fn.stdpath("config") .. "/lua/dannyjr/luasnip",
  })
end

-- 9. (Opcional) Plugins que requieren Python más adelante
safe_require("dannyjr.plugins.lsp.none-ls-autoload")

