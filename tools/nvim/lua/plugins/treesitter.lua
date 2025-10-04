return {
  -- add more treesitter parsers
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = require('nvim-treesitter.parsers').available_parsers()
      return opts
    end,
  },
}
