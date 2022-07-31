local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local url = 'https://github.com/wbthomason/packer.nvim'

-- Automatically install packer if not exists
if fn.empty(fn.glob(install_path)) > 0 then
  fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd('packadd packer.nvim')
  isBootstrap = true
end

-- Plugin installation
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme inspired by Gruvbox
  use 'ellisonleao/gruvbox.nvim'
  
  -- statusline plugin
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

end)

-- installing plugins, we need to restart nvim, and then it will work.
if isBootstrap then require('packer').update() end
return isBootstrap and true or false
