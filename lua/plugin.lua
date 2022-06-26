local ok, packer = pcall(require, 'packer')

if not ok then
  return
end

function config_path(name)
  return string.format('require("setup.%s")', name)
end

function use_plugins()
  -- package manager
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    config = config_path('nvim-treesitter')
  }

  -- developement: general
  use 'editorconfig/editorconfig-vim'
  use {
    'lewis6991/gitsigns.nvim',
    config = config_path('gitsigns'),
  }
  use {
    'numToStr/Comment.nvim',
    config = config_path('comment'),
  }

  -- motion
  use {
    'phaazon/hop.nvim',
    config = config_path('hop'),
  }

  -- session
  use {
    'rmagatti/auto-session',
    config = config_path('auto-session'),
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    config = config_path('nvim-lspconfig'),
  }
  use { 'tami5/lspsaga.nvim' }

  -- autocomplete
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = config_path('telescope'),
  } -- fuzzy finder

  use {
    'kyazdani42/nvim-tree.lua',
    config = config_path('nvim-tree'),
  } -- file explorer

  -- display
  use 'arcticicestudio/nord-vim' -- theme
  use {
    'nvim-lualine/lualine.nvim',
    config = config_path('lualine'),
  } -- status line
  use {
    'akinsho/bufferline.nvim',
    config = config_path('bufferline'),
  } -- bufferline
  use {
    'chentoast/marks.nvim',
    config = config_path('marks'),
  } -- marks
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = config_path('indent-blankline'),
  } -- indent guide line
  use {
    'folke/which-key.nvim',
    config = config_path('which-key')
  } -- key viewer
  use 'kyazdani42/nvim-web-devicons'
end

packer.startup(use_plugins)
