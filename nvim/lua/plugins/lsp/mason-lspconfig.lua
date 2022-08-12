local exists, mason_lspconfig = pcall(require, "mason-lspconfig")
if not exists then
  return
end

-- local common = require('plugins.lsp.common')

-- extract language server name from the language config files
-- local language_server_packages = {}
-- for _, language in pairs(common.languages) do
--   local language_data = require("plugins.lsp.languages." .. language)
--   table.insert(language_server_packages, language_data.package)
-- end

mason_lspconfig.setup({
  -- automatic_installation = true,
  -- ensure_installed = language_server_packages,
})
