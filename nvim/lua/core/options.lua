--------------------------------------------------------------------------------------- UI based

-- Make line numbers default
vim.opt.number = true   -- Show line numbers
vim.opt.relativenumber = true   -- Show line numbers relatively

-- vim.opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
-- vim.opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
-- vim.opt.splitright = true       -- Vertical split to the right
-- vim.opt.splitbelow = true       -- Horizontal split to the bottom

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true       -- Ignore case letters when search
vim.opt.smartcase = true        -- Ignore lowercase for the whole pattern
vim.opt.showmatch = true        -- Highlight matching parenthesis
vim.o.hlsearch = false          -- Set highlight of the privious search

-- vim.opt.linebreak = true        -- Wrap on word boundary
-- vim.opt.termguicolors = true    -- Enable 24-bit RGB colors
-- vim.opt.laststatus=3            -- Set global statusline

-- use terminal truecolors
vim.opt.termguicolors = true

--------------------------------------------------------------------------------------- Tabs, indent

vim.opt.expandtab = false        -- Use spaces instead of tabs
vim.opt.shiftwidth = 2          -- Shift 2 spaces when tab
vim.opt.tabstop = 2             -- 1 tab == 2 spaces
vim.opt.smartindent = true      -- Autoindent new lines

--------------------------------------------------------------------------------------- Memory, CPU

-- vim.opt.hidden = true           -- Enable background buffers
-- vim.opt.history = 100           -- Remember N lines in history
-- vim.opt.lazyredraw = true       -- Faster scrolling
-- vim.opt.synmaxcol = 240         -- Max column for syntax highlight
vim.opt.updatetime = 500        -- ms to wait for trigger an event

---------------------------------------------------------------------------------------  Misc

-- vim.opt.clipboard = 'unnamedplus'                  -- Copy/paste to system clipboard
-- vim.opt.swapfile = false                           -- Don't use swapfile

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options


