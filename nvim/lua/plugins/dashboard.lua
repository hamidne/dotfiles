local dashboard = require('dashboard')

dashboard.custom_header = {
  '',
  '',
  '██████╗   █████╗  ███████╗ ██╗  ██╗ ██████╗   ██████╗   █████╗  ██████╗  ██████╗ ',
  '██╔══██╗ ██╔══██╗ ██╔════╝ ██║  ██║ ██╔══██╗ ██╔═══██╗ ██╔══██╗ ██╔══██╗ ██╔══██╗',
  '██║  ██║ ███████║ ███████╗ ███████║ ██████╔╝ ██║   ██║ ███████║ ██████╔╝ ██║  ██║',
  '██║  ██║ ██╔══██║ ╚════██║ ██╔══██║ ██╔══██╗ ██║   ██║ ██╔══██║ ██╔══██╗ ██║  ██║',
  '██████╔╝ ██║  ██║ ███████║ ██║  ██║ ██████╔╝ ╚██████╔╝ ██║  ██║ ██║  ██║ ██████╔╝',
  '╚═════╝  ╚═╝  ╚═╝ ╚══════╝ ╚═╝  ╚═╝ ╚═════╝   ╚═════╝  ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═════╝ ',
  '',
  '',
}

dashboard.custom_center = {
  {
    icon = '  ',
    desc = 'New  File                               ',
    action = 'enew',
    shortcut = '<Leader> e  ',
  },
  {
    icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files',
    shortcut = '<Leader> f f',
  },
  {
    icon = '  ',
    desc = 'Recently Opened Files                   ',
    action = 'Telescope oldfiles',
    shortcut = '<Leader> f r',
  },
  {
    icon = '  ',
    desc = 'Project grep                            ',
    action = 'Telescope project',
    shortcut = '<Leader> f g',
  },
  {
    icon = '  ',
    desc = 'Update Plugins                          ',
    action = 'PackerUpdate',
    shortcut = '<Leader> u  ',
  },
  {
    icon = '  ',
    desc = 'Open Dotfiles                           ',
    action = ':e ~/.dotfiles',
    shortcut = '<Leader> e v',
  },
  {
    icon = '  ',
    desc = 'Quit Nvim                               ',
    action = 'qa',
    shortcut = 'q           '
  }
}

vim.cmd([[
  augroup dashboard_enter
    au!
    autocmd FileType dashboard nnoremap <buffer> q :qa<CR>
    autocmd FileType dashboard nnoremap <buffer> e :enew<CR>
  augroup END
]])
