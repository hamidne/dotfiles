local exists, configs = pcall(require, "nvim-treesitter.configs")
if not exists then
  return
end

local common = require('plugins.lsp.common')

configs.setup {
    ensure_installed = common.languages, -- list of language parsers to be installed
    ignore_install = {}, -- list of parsers to ignore installing
    
    -- highlighting configuration
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {}, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },

    incremental_selection = { enable = true }, --
    indent = { enable = true }, --
}

