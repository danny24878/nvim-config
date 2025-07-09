-- ~/.config/nvim/lua/dannyjr/plugins/lsp/capabilities.lua

local M = {}

local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
  vim.notify("⚠️ No se pudo cargar cmp_nvim_lsp", vim.log.levels.WARN)
  M.capabilities = vim.lsp.protocol.make_client_capabilities()
  return M
end

M.capabilities = cmp_nvim_lsp.default_capabilities()

return M

