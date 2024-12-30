vim.api.nvim_set_var("loaded_netrw", 1)
vim.api.nvim_set_var("loaded_netrwPlugin", 1)
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Startup settings
-- vim.api.nvim_create_augroup('startUp', { clear = true })
-- vim.api.nvim_create_autocmd('VimEnter', {
--   group = 'startUp',
--   callback = function()
--     require("nvim-tree.api").tree.open()
--   end,
-- })
