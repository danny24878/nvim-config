-- ~/.config/nvim/lua/dannyjr/plugins/airline.lua

-- Configuración de vim-airline
vim.g.airline_theme = 'bubblegum'
vim.g.airline_powerline_fonts = 1
vim.g.airline_section_y = '%{strftime("%c")}'
vim.g.airline_section_z = ' %{getcwd()} '
vim.g.airline_extensions = {'branch', 'hunks'}

