

-- Importa plugins necesarios
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then return end

local typescript_ok, typescript = pcall(require, "typescript")
if not typescript_ok then return end

-- Carga configuración modular
local on_attach = require("dannyjr.plugins.lsp.on_attach")
local capabilities = require("dannyjr.plugins.lsp.capabilities").capabilities
local luasnip = require("luasnip")

-- Lista de servidores simples (sin configuración especial)
local servers = {
  "html",
  "cssls",
  "tailwindcss",
  "emmet_ls",
  "lua_ls",
  "pyright",
  "pylsp",
  "texlab",
}

-- Opciones comunes
local default_opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Configura todos los servidores simples
for _, server in ipairs(servers) do
  lspconfig[server].setup(default_opts)
end

-- Configuración especial para typescript
typescript.setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
})

-- Configuración adicional para pylsp (si lo usas además de pyright)
lspconfig["pylsp"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = true },
        pyflakes = { enabled = true },
        flake8 = { enabled = true },
        black = { enabled = true },
        pylint = { enabled = true },
        jedi_completion = { fuzzy = true }
      }
    }
  }
})

-- Configuración específica de texlab
lspconfig["texlab"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = true,
      },
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
      chktex = {
        onEdit = true,
        onOpenAndSave = true,
      },
    }
  }
})
