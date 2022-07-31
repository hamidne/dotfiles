-- setup gruvbox colorscheme
require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    overrides = {
      SignColumn = {bg = "#ff9900"}
    },
})

-- set background (dark or light)
vim.o.background = "dark"

-- vim.cmd("%left 1")
-- vim.cmd("hi LineNr guibg=#000000 guifg=#ffffff")

-- set colorscheme to gruvbox
vim.cmd("colorscheme gruvbox")

