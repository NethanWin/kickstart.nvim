vim.keymap.set('n', '<C-i>', ':HebrewInsert<CR>', { noremap = true, silent = true })
vim.api.nvim_create_user_command('HebrewInsert', function()
  local prev_keymap = vim.o.keymap
  vim.g.hebrew_prev_keymap = prev_keymap

  vim.opt_local.keymap = 'hebrew'
  --vim.cmd 'startinsert!'
  vim.cmd 'startinsert'

  vim.api.nvim_create_autocmd('InsertLeave', {
    once = true,
    callback = function()
      vim.opt_local.keymap = vim.g.hebrew_prev_keymap or ''
      vim.g.hebrew_prev_keymap = nil
    end,
  })
end, {})

--vim.api.nvim_create_autocmd('VimEnter', {
-- callback = function()
-- vim.cmd 'BidiEnable LR'
-- end,
-- once = true,
-- })

-- 'BufWritePost'
-- 'BufEnter' - on entering file but not save
-- BufWinEnter - on entering a file in a window
vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
  group = group,
  callback = function(args)
    vim.cmd 'BidiEnable LR'
  end,
})
