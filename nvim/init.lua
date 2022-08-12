-- [[
-- ]]

--  NOTE: core Must happen before plugins are required
require('core.mappings') -- keymaps binding configurations
require('core.options') -- neovim options

-- in case we are loading the plugins, we return and don't setup them
require('plugins')
