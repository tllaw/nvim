local ok, packer = pcall(require, 'packer')

if not ok then
  return
end

function use_plugins()
  -- package manager
  use 'wbthomason/packer.nvim'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = require('setup.nvim-treesitter'),
  }

  -- language server protocol
  use {
    'neovim/nvim-lspconfig',
    config = require('setup.nvim-lspconfig'),
  } -- lsp
  use {
    'kkharji/lspsaga.nvim',
    config = require('setup.lspsaga'),
  } -- lsp ui
  use {
    'folke/trouble.nvim',
    config = require('setup.trouble'),
  } -- lsp diagnostic list
  use 'simrat39/symbols-outline.nvim' -- lsp symbol list

  -- autocomplete
  use { 'ms-jpq/coq_nvim', run = 'python3 -m coq deps' }
  use 'ms-jpq/coq.artifacts'
  use 'ms-jpq/coq.thirdparty'

  -- fuzzy finder
  use 'ibhagwan/fzf-lua'

  -- status line
  use {
    'akinsho/bufferline.nvim',
    config = require('setup.bufferline'),
  } -- buffer line
  use {
    'nvim-lualine/lualine.nvim',
    config = require('setup.lualine'),
  } -- status line

  -- file explorer
  use {
    'kyazdani42/nvim-tree.lua',
    config = require('setup.nvim-tree'),
  }

  -- display
  use 'folke/tokyonight.nvim' -- theme
  use {
    'chentoast/marks.nvim',
    config = require('setup.marks'),
  } -- marks
  use 'kyazdani42/nvim-web-devicons' -- icons
end

packer.startup(use_plugins)
