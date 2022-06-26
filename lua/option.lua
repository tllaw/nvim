local opt = vim.opt
local g = vim.g

---------------------
-- general options --
---------------------

-- indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

-- display
opt.number = true
opt.relativenumber = true
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.cursorline = true
opt.showmode = false
opt.list = true
opt.listchars:append {
  eol = '↵',
  tab = '▶ ',
  trail = '▓',
  space = '·'
}

-- motion
opt.whichwrap:append '[,],<,>'

-- search
opt.ignorecase = true
opt.smartcase = true

-- split
opt.splitright = true
opt.splitbelow = true

-- performance
opt.lazyredraw = true

-- sign column
opt.signcolumn = 'yes'

-- undofile
opt.undofile = true

--------------------
-- plugin options --
--------------------

-- nord
vim.cmd [[
  colorscheme nord
]]
