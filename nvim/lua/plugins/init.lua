local fn = vim.fn

-- Automatically install packer if not exists
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  local url = 'https://github.com/wbthomason/packer.nvim'
  PACKER_BOOTSTRAP = fn.system {"git", "clone", "--depth", "1", url, install_path}
  fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd('packadd packer.nvim')
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  -- snapshot = "july-24",
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function() return require("packer.util").float { border = "rounded" } end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

-- Plugins installation & configurations goes here
packer.startup(function(use)
  use 'wbthomason/packer.nvim' ----------------------------------------- Packer can manage itself
	
  ---------------------------------------------------------------------- Language Server Protocol Related

  -- Language parsing library (syntax highlighting)
  use { 'nvim-treesitter/nvim-treesitter', config = function() require('plugins.lsp.nvim-treesitter') end } 
  
  -- Package Manager for LSP & enable mason.nvim to use built-in lspconfig
  use { 'williamboman/mason.nvim' , config = function() require('plugins.lsp.mason') end }
  use { 'williamboman/mason-lspconfig.nvim', config = function() require('plugins.lsp.mason-lspconfig') end }
  
  use 'jose-elias-alvarez/null-ls.nvim' -- Linter & Formatter
  
  -- Adds pictograms to built-in lsp, specifies autocommand which load this plugin
  use { 'onsails/lspkind-nvim', event = 'VimEnter' }

  -- Autocompletion
  use { 'hrsh7th/nvim-cmp', config = function() require('plugins.lsp.nvim-cmp') end }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }

  -- Native LSP client support
  use { 'neovim/nvim-lspconfig', config = function() require('plugins.lsp.lspconfig') end }

  -- For vsnip users.
  use 'hrsh7th/cmp-vsnip' 
  use 'hrsh7th/vim-vsnip' 

	use 'christianchiarulli/lua-dev.nvim' -- lua development
	use "b0o/schemastore.nvim" -- Access to schemastores catalog

  ---------------------------------------------------------------------- Others

  -- onedark colorschems
  use { 'navarasu/onedark.nvim', config = function() require('plugins.onedark') end }

  use {
    'nvim-telescope/telescope.nvim', -- Fuzzy Finder
    config = function() require('plugins.telescope') end,
    requires = { 'nvim-lua/plenary.nvim', opt = true },
  }

	use 'nvim-telescope/telescope-media-files.nvim'

  use {
    'kyazdani42/nvim-tree.lua', -- Explorers
    config = function() require('plugins.nvim-tree') end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  use {
    'nvim-lualine/lualine.nvim', -- Statuslines
    config = function() require('plugins.lualine') end, 
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use { 
    'akinsho/bufferline.nvim', -- Buffer
    config = function() require('plugins.bufferline') end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    'glepnir/dashboard-nvim',
    config = function() require('plugins.dashboard') end,
  }

  use 'nvim-lua/plenary.nvim'
  use "kyazdani42/nvim-web-devicons" -- Icons (required by other plugins)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then packer.sync() end
end)
