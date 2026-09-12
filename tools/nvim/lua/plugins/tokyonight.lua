return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "night",
      on_highlights = function(hl, colors)
        hl["@lsp.type.variable"] = { fg = colors.green }

        hl.Number = { fg = colors.yellow }
        hl.Constant = { fg = colors.yellow }

        hl.String = { fg = colors.orange }
        hl["@string"] = { fg = colors.orange }
        hl["@lsp.type.string"] = { fg = colors.orange }

        hl["@parameter"] = { fg = colors.red }
        hl["@lsp.type.parameter"] = { fg = colors.red }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
