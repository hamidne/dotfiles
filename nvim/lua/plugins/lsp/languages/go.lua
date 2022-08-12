local M = {}

M.package = 'gopls'

M.server = 'gopls'

M.config = {
  cmd = { 'gopls' },
  settings = {
    gopls = {
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      experimentalPostfixCompletions = true,
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
}

return M