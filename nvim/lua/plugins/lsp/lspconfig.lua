local common = require('plugins.lsp.common')

local capabilities = common.capabilities

-- update capabilities if cmp_nvim_lsp exists
local exists, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if exists then
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

local exists, lspconfig = pcall(require, "lspconfig")
if not exists then
  return
end

for _, language in pairs(common.languages) do
  local configs = {
    on_attach = common.on_attach,
    capabilities = capabilities,
  }

  -- load language data and add it to the language configs
  local language_data = require("plugins.lsp.languages." .. language)
  configs = vim.tbl_deep_extend("force", language_data.config, configs)

  -- setup lspconfig with provided configs
  lspconfig[language_data.server].setup(configs)
end
