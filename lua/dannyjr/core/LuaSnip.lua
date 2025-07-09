-- ~/.config/nvim/lua/dannyjr/core/luasnip_fix.lua
local M = {}

function M.setup()
  local ok, luasnip = pcall(require, 'luasnip')
  if not ok then return end
  luasnip.setup({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged",
  })
  -- Carga mínima de snippets
  require('luasnip.loaders.from_vscode').lazy_load()
  require("luasnip.loaders.from_lua").lazy_load({
  paths = vim.fn.stdpath("config") .. "/lua/dannyjr/luasnip",
})
end

return M
