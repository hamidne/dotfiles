local exists, nvim_tree = pcall(require, "nvim-tree")
if not exists then
  return
end

local diagnostics_icons = require('icons.diagnostics')
local folder_icons = require('icons.folder')
local git_icons = require('icons.git')

nvim_tree.setup({
	sort_by = "case_sensitive",
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			error = diagnostics_icons.error,
			warning = diagnostics_icons.warning,
			info = diagnostics_icons.info,
			hint = diagnostics_icons.hint,
		  },
	},
	view = {},
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = folder_icons.arrow_closed,
					arrow_open = folder_icons.arrow_open,
					default = folder_icons.default,
					open = folder_icons.open,
					empty = folder_icons.empty,
					empty_open = folder_icons.empty_open,
					symlink = folder_icons.symlink,
					symlink_open = folder_icons.symlink_open,
				},
				git = {
					unstaged = git_icons.unstaged,
					staged = git_icons.staged,
					unmerged = git_icons.unmerged,
					renamed = git_icons.renamed,
					untracked = git_icons.untracked,
					deleted = git_icons.deleted,
					ignored = git_icons.ignored,
				}
			}
		}
	}
})

