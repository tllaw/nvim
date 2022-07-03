local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

if not ok then
  return
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'ruby', 'typescript', 'scss' },
  sync_install = false,
  highlight = {
    enable = true,
  },
}
