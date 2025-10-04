return {
  -- add more treesitter parsers
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = type(opts.ensure_installed) == 'table' and opts.ensure_installed or {}

      local ok, parsers = pcall(require, 'nvim-treesitter.parsers')
      if ok and type(parsers) == 'table' and type(parsers.available_parsers) == 'function' then
        local available = parsers.available_parsers()
        if type(available) == 'table' then
          opts.ensure_installed = available
        end
      end
      return opts
    end,
  },
}
