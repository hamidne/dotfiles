local exists, lua_dev = pcall(require, "lua-dev")
if not exists then
  return
end

local M = {}

M.package = 'lua-language-server'

M.server = 'sumneko_lua'

M.config = lua_dev.setup {}

return M
