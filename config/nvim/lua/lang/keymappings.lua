local default_options = {noremap=true}
local function vim_cmd_string(cmd)
  return string.format('<CMD>%s<CR>', cmd)
end

vim.api.nvim_set_keymap('n', '<a-n>', vim_cmd_string('lua require"illuminate".next_reference{wrap=true}'), default_options)
vim.api.nvim_set_keymap('n', '<a-p>', vim_cmd_string('lua require"illuminate".next_reference{reverse=true,wrap=true}'), default_options)
vim.api.nvim_set_keymap('n', '<leader>i', '<cmd>CodeCompanionActions<cr>', default_options)
vim.api.nvim_set_keymap('n', '<C-i>', '<cmd>CodeCompanionActions<cr>', default_options)
-- vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>CodeCompanionChat Toggle<cr>', default_options)
--vim.keymap('n', '<C>a', '<cmd>CodeCompanionActions<cr>', default_options)
