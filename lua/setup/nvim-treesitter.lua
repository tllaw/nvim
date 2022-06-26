local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

if not ok then
  return
end

nvim_treesitter.setup {}
