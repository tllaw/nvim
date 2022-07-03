local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.scrolloff = 10
opt.sidescrolloff = 10

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.list = true
opt.listchars:append {
  eol = '↵',
  tab = '▶ ',
  trail = '▓',
  space = '·'
}
