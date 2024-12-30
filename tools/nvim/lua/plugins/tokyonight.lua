return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
    config = function()
      require("tokyonight").setup({
        style = "night",
        -- Change colorscheme
        on_highlights = function(hl, c)
          hl["@lsp.type.variable"] = { fg = c.green }

          hl.Number = { fg = c.yellow }
          hl.Constant = { fg = c.yellow }

          hl.String = { fg = c.orange }
          hl["@string"] = { fg = c.orange }
          hl["@lsp.type.string"] = { fg = c.orange }

          hl["@parameter"] = { fg = c.red }
          hl["@lsp.type.parameter"] = { fg = c.red }
        end,
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
      -- Change colorscheme
    end,
  }
}
