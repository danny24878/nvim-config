-- ~/.config/nvim/lua/dannyjr/plugins/mason.lua

-- Importar y configurar Mason
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

-- Importar mason-lspconfig
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

-- Importar mason-tool-installer
local mason_tool_installer_status, mason_tool_installer = pcall(require, "mason-tool-installer")
if not mason_tool_installer_status then
  return
end

-- Configurar Mason y los iconos de la interfaz de usuario
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

mason_lspconfig.setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "emmet_ls",
    "graphql",
    "html",
    "jsonls",
    "lua_ls",
    "pyright",
    "svelte",
    "tailwindcss",
    "texlab",
    "yamlls",
  },
  automatic_installation = true,
})

-- Herramientas extra (formatters, linters, etc.)
mason_tool_installer.setup({
  ensure_installed = {
    -- Python
    "black",
    "isort",
    "pylint",

    -- Lua
    "stylua",

    -- JavaScript/TypeScript
    "prettier",
    "eslint_d",
  },
  auto_update = false,
  run_on_start = true,
  start_delay = 3000, -- 3 segundos de espera tras iniciar Neovim
})

