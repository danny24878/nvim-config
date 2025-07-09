local lspconfig = require("lspconfig")
local on_attach = require("dannyjr.plugins.lsp.on_attach")
local capabilities = require("dannyjr.plugins.lsp.capabilities")

vim.notify("Cargando servidores LSP...", vim.log.levels.INFO)

-- HTML
lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })

-- CSS
lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })

-- Tailwind
lspconfig.tailwindcss.setup({ capabilities = capabilities, on_attach = on_attach })

-- Emmet
lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- Pyright
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
      },
    },
  },
})

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

-- LaTeX
lspconfig.texlab.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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
    },
  },
})

