local modules = {
  'plugin',
  'option',
  'plugin-option',
  'mapping',
}

for _, module in ipairs(modules) do
  pcall(require, module)
end
