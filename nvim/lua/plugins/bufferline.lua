local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local diagnostics_icons = require('icons.diagnostics') 

bufferline.setup {
	options = {
		indicator = {
			icon = "",
		},

		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diagnostics_dict, _)
			local s = " "

			local function checker(value, icon)
				local count = diagnostics_dict[value]
				if count then s = s .. ' ' .. icon .. ' ' .. count end
			end

			checker("error", diagnostics_icons.error)
			checker("warning", diagnostics_icons.warning)
			checker("info", diagnostics_icons.info)
			checker("question", diagnostics_icons.question)
			checker("hint", diagnostics_icons.hint)

			return s
		end,

		offsets = {{
			filetype = "NvimTree",
			text = function()
				local path = vim.fn.getcwd()
				local splits = {}

				for directory in string.gmatch(path, '([^/]+)') do
					splits[#splits+1] = directory
				end

				return splits[#splits]
			end,
			padding = 1,
		}},

		color_icons = true,
		show_buffer_close_icons = false,
		show_buffer_default_icon = true,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = true,

		separator_style = "thin",
		enforce_regular_tabs = false,
		always_show_bufferline = true,

		sort_by = function (buffer_a, buffer_b)
			print(vim.inspect(buffer_a))
			-- add custom logic
			local mod_a = vim.loop.fs_stat(buffer_a.path).mtime.sec
			local mod_b = vim.loop.fs_stat(buffer_b.path).mtime.sec
			return mod_a > mod_b
		end
	},

	highlights = {
		--		fill = {
		--			guifg = { attribute = "fg", highlight = "#0d69fc" },
		--			guibg = { attribute = "bg", highlight = "#fc0d25" },
		--		},
		--    background = {
		--      guifg = { attribute = "fg", highlight = "TabLine" },
		--      guibg = { attribute = "bg", highlight = "TabLine" },
		--    },
		-- buffer_selected = {
		--   guifg = {attribute='fg',highlight='#ff0000'},
		--   guibg = {attribute='bg',highlight='#0000ff'},
		--   gui = 'none'
		--   },
		--   buffer_visible = {
		--     guifg = { attribute = "fg", highlight = "Normal" },
		--     guibg = { attribute = "bg", highlight = "Normal" },
		--   },
		--   close_button = {
		--     guifg = { attribute = "fg", highlight = "TabLine" },
		--     guibg = { attribute = "bg", highlight = "TabLine" },
		--   },
		--   close_button_visible = {
		--     guifg = { attribute = "fg", highlight = "TabLine" },
		--     guibg = { attribute = "bg", highlight = "TabLine" },
		--   },
		--   close_button_selected = {
		--     guifg = {attribute='fg',highlight='TabLineSel'},
		--     guibg ={attribute='bg',highlight='TabLineSel'}
		--   },
		--   tab_selected = {
		--     guifg = { attribute = "fg", highlight = "Normal" },
		--     guibg = { attribute = "bg", highlight = "Normal" },
		--   },
		--   tab = {
		--     guifg = { attribute = "fg", highlight = "TabLine" },
		--     guibg = { attribute = "bg", highlight = "TabLine" },
		--   },
		--   tab_close = {
		--     -- guifg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
		--     guifg = { attribute = "fg", highlight = "TabLineSel" },
		--     guibg = { attribute = "bg", highlight = "Normal" },
		--   },
		--   duplicate_selected = {
		--     guifg = { attribute = "fg", highlight = "TabLineSel" },
		--     guibg = { attribute = "bg", highlight = "TabLineSel" },
		--     gui = "italic",
		--   },
    --   duplicate_visible = {
		--     guifg = { attribute = "fg", highlight = "TabLine" },
		--     guibg = { attribute = "bg", highlight = "TabLine" },
		--     gui = "italic",
		--   },
		--   duplicate = {
		--     guifg = { attribute = "fg", highlight = "TabLine" },
		--     guibg = { attribute = "bg", highlight = "TabLine" },
		--     gui = "italic",
		--   },
		--   modified = {
		--     guifg = { attribute = "fg", highlight = "TabLine" },
		--     guibg = { attribute = "bg", highlight = "TabLine" },
		--   },
		--   modified_selected = {
		--     guifg = { attribute = "fg", highlight = "Normal" },
		--     guibg = { attribute = "bg", highlight = "Normal" },
		--   },
		--   modified_visible = {
		--     guifg = { attribute = "fg", highlight = "TabLine" },
		--     guibg = { attribute = "bg", highlight = "TabLine" },
		--   },
		--   separator = {
		--     guifg = { attribute = "bg", highlight = "TabLine" },
		--     guibg = { attribute = "bg", highlight = "TabLine" },
		--   },
		--   separator_selected = {
		--     guifg = { attribute = "bg", highlight = "Normal" },
		--     guibg = { attribute = "bg", highlight = "Normal" },
		--   },
		--   separator_visible = {
		--     guifg = {attribute='bg',highlight='TabLine'},
		--     guibg = {attribute='bg',highlight='TabLine'}
		--   },
		--   indicator_selected = {
		--     guifg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
		--     guibg = { attribute = "bg", highlight = "Normal" },
		--   },
	},
}

