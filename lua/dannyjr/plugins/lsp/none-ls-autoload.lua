local M = {}

function M.setup()
  local setup, none_ls = pcall(require, "none-ls")
  if not setup then
    return
  end

  local formatting = none_ls.builtins.formatting
  local diagnostics = none_ls.builtins.diagnostics

  none_ls.setup({
    sources = {
      -- Fuentes existentes
      formatting.prettier,
      formatting.stylua,
      diagnostics.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file(".eslintrc.js")
        end,
      }),
      
      -- Nuevas fuentes para Python
      formatting.black.with({
        extra_args = { "--fast" },
        condition = function(utils)
          return utils.root_has_file({"pyproject.toml", "requirements.txt", "setup.py"})
        end,
      }),
      
      formatting.isort.with({
        condition = function(utils)
          return utils.root_has_file({"pyproject.toml", "requirements.txt", "setup.py"})
        end,
      }),
      
      diagnostics.flake8.with({
        extra_args = { "--max-line-length=88", "--ignore=E203,W503" },
        condition = function(utils)
          return utils.root_has_file({"pyproject.toml", "requirements.txt", "setup.py"})
        end,
      }),
      
      diagnostics.mypy.with({
        condition = function(utils)
          return utils.root_has_file({"pyproject.toml", "requirements.txt", "setup.py"})
        end,
      }),
      
      diagnostics.pylint.with({
        condition = function(utils)
          return utils.root_has_file({"pyproject.toml", "requirements.txt", "setup.py"})
        end,
      }),
    },
  })
end

return M
