

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1",
      "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Auto actualizar plugins al guardar este archivo
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup END
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Plugin manager

  -- Plugins esenciales y soporte
  use("nvim-lua/plenary.nvim")
  use("bluz71/vim-nightfly-guicolors")

  -- Plugins básicos (sin require aquí)
  use("kyazdani42/nvim-tree.lua")
  use("nvim-lualine/lualine.nvim")
  use("numToStr/Comment.nvim")
  use("lewis6991/gitsigns.nvim")
  use("windwp/nvim-autopairs")
  use("kylechui/nvim-surround")
use ({
  'nvim-telescope/telescope-fzf-native.nvim',
  run = 'make',
})
 use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("lervag/vimtex")
  use("vim-airline/vim-airline-themes")
  use("hrsh7th/nvim-cmp")
  use("szw/vim-maximizer")

 -- LSP y herramientas
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("WhoIsSethDaniel/mason-tool-installer.nvim")
  use("onsails/lspkind.nvim")
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })
  use("jose-elias-alvarez/null-ls.nvim")

  -- Snippets
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets")
  use("saadparwaiz1/cmp_luasnip")

  -- Autocompletado adicional
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-nvim-lsp")

  -- Si es la primera instalación, sincroniza plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
