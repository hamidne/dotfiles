local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
  return
end

local M = {}

M.package = 'json-lsp'

M.server = 'jsonls'

M.config = {
  init_options = {
    provideFormatter = false,
  },
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
			validate = { enable = true },
		},
  },
  setup = {
    commands = {
      -- Format = {
      --   function()
      --     vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
      --   end,
      -- },
    },
  },
}

return M
