-- Use a protected call so we don't error out on first use
local status_ok, mason = pcall(require, "mason")
if not status_ok then
return
end

mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

