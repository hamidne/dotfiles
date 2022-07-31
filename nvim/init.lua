-- [[
-- ]]

--  NOTE: core Must happen before plugins are required
require('core.mappings') -- key maps, binding configurations
require('core.options') -- nvim options and configuration

-- in case we are loading the plugins, we return and don't setup them
if require('plugins.init') then return end

require('plugins.config.statusline') -- Plugins
require('plugins.config.colorscheme') -- Plugins
