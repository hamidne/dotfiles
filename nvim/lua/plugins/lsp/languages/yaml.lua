local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
  return
end

local M = {}

M.package = 'yaml-language-server'

M.server = 'yamlls'

M.config = {
  yaml = {
    schemaStore = { enable = true }
  }
}

return M
