--==================================--
-- Maintainer: Tin-Lok LAW (@tllaw) --
--==================================--


--========--
-- Plugin --
--========--

require('packer').startup(function(use)
  -- plugin manager
  use 'wbthomason/packer.nvim'

  -- development: general
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'
  use 'ms-jpq/coq_nvim'
  use 'ms-jpq/coq.artifacts'
  use 'ms-jpq/coq.thirdparty'
  use 'editorconfig/editorconfig-vim'
  use 'lewis6991/gitsigns.nvim'

  -- development: rails
  use 'tpope/vim-rails'
  use 'airblade/vim-localorie'

  -- session
  use 'rmagatti/auto-session'

  -- motion
  use 'phaazon/hop.nvim'

  -- finder
  use 'kevinhwang91/rnvimr'
  use 'ibhagwan/fzf-lua'

  -- display
  use 'catppuccin/nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'chentoast/marks.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'folke/which-key.nvim'
  use 'petertriho/nvim-scrollbar'
  use 'kyazdani42/nvim-web-devicons'
end)


--==============--
-- Plugin Setup --
--==============--

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  auto_install = true,
  highlight = {
    enable = true
  }
}

-- nvim-lspconfig
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local servers = { 'solargraph', 'eslint', 'stylelint_lsp' }
for _, server in ipairs(servers) do
  require('lspconfig')[server].setup(require('coq').lsp_ensure_capabilities {
    on_attach = on_attach,
  })
end

-- gitsigns
require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_formatter = ' * [<abbrev_sha>] <author>, <author_time:%Y-%m-%d> - <summary>',
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>gs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>gS', gs.stage_buffer)
    map('n', '<leader>gu', gs.undo_stage_hunk)
    map('n', '<leader>gR', gs.reset_buffer)
    map('n', '<leader>gp', gs.preview_hunk)
    map('n', '<leader>gb', function() gs.blame_line{full=true} end)
    map('n', '<leader>gd', gs.diffthis)
    map('n', '<leader>gD', function() gs.diffthis('~') end)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- auto-session
require('auto-session').setup {
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_use_git_branch = true,
}

-- hop
require('hop').setup {}

-- catppuccin
require('catppuccin').setup {}
vim.cmd 'colorscheme catppuccin-mocha'

-- lualine
require('lualine').setup {
  tabline = {
    lualine_a = {{ 'buffers', mode = 4 }}
  },
  winbar = {
    lualine_b = {
      {
        'filetype',
        icon_only = true,
        separator = ''
      },
      'filename'
    }
  },
  inactive_winbar = {
    lualine_c = {
      {
        'filetype',
        icon_only = true,
        separator = ''
      },
      'filename'
    }
  },
  sections = {
    lualine_c = {}
  }
}

-- indent-blankline
require('indent_blankline').setup {}

-- marks
require('marks').setup {}

-- scrollbar
require('scrollbar').setup {}

-- which-key
require('which-key').setup {}

-- rnvimr
vim.cmd [[
  let g:rnvimr_presets = [{'width': 0.950, 'height': 0.950}]
]]


--========--
-- Option --
--========--

-- indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftround = true

-- display
vim.opt.scrolloff = 10

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.laststatus = 3

vim.opt.list = true
vim.opt.listchars:append {
  eol = '↵',
  tab = '▶ ',
  trail = '▓',
  space = '·'
}

-- motion
vim.opt.whichwrap:append '[,],<,>'
vim.opt.mouse = ''

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- split
vim.opt.splitright = true
vim.opt.splitbelow = true


--==============--
-- Key Mappings --
--==============--

vim.g.mapleader = ','

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true, }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- general
map('n', '<esc>', ':nohlsearch<cr>', { silent = true }) -- exit highlight search
map('n', '\\', ',')                                     -- reverse searching

-- buffer
map('n', 'gb', '":<c-U>" . v:count1 . "bn<cr>"', { expr = true })
map('n', 'gB', '":<c-U>" . v:count1 . "bp<cr>"', { expr = true })
map('n', '<leader>b', '":<c-U>" . (v:count > 0 ? v:count : "") . "b<cr>"', { expr = true })
map('n', '<leader>q', '":<c-U>" . (v:count > 0 ? v:count : "") . "bd<cr>"', { expr = true })

-- hop
map('n', '<leader>hw', ':HopWord<cr>')
map('n', '<leader>hp', ':HopPattern<cr>')
map('n', '<leader>hl', ':HopLine<cr>')

-- rnvimr
map('n', '<leader>/', ':RnvimrToggle<cr>')

-- fzf-lua
map('n', '<leader>ff', ':FzfLua files<cr>')
map('n', '<leader>fg', ':FzfLua grep<cr><cr>')
map('n', '<leader>fb', ':FzfLua buffers<cr><cr>')

-- localories
map('n', '<leader>lt', ':call localorie#translate()<cr>')

-- rails: wrap region
vim.cmd [[
  function! WrapRegion() range
    let region_name = input('Region Name? ')
    execute "normal " .. a:firstline .. "GV" .. a:lastline .. "GdO# region " .. region_name .. "\<CR>\<BS>\<BS>\<CR>\<CR># endregion " .. region_name .. "\<ESC>2kp"
  endfunction
  vnoremap <leader>wr :call WrapRegion()<cr>
]]


--==============--
-- Auto Command --
--==============--

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('initialize', { clear = true })
autocmd({ 'VimEnter' }, {
  command = 'COQnow'
})
autocmd({ 'CursorMoved' }, {
  pattern = { '*.yml' },
  command = 'echo localorie#expand_key()'
})
